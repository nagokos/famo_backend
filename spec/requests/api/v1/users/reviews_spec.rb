require 'rails_helper'

# /api/v1/users/:user_id/reviews
# POST   /api/v1/users/:user_id/reviews

RSpec.describe 'Api::V1::Users::Reviews', type: :request do
  let!(:reviewer) { create(:user) }
  let!(:reviewee) { create(:user, :player) }
  let!(:header) { { 'X-Requested-With': 'XMLHttpRequest' } }
  describe 'GET /api/v1/users/:user_id/reviews' do
    context 'sort=created' do
      let!(:latest_review) { create(:review, reviewer: reviewer, reviewee: reviewee, created_at: Time.current) }
      let!(:old_review) { create(:review, reviewer: reviewer, reviewee: reviewee, created_at: Time.current.ago(1.days)) }
      before { get "/api/v1/users/#{reviewer.id}/reviews", params: { q: { sort: 'created' } } }

      it '作成日を基準に降順に並び替える' do
        expect(json['reviews'].first['id']).to eq(latest_review.id)
        expect(json['reviews'].last['id']).to eq(old_review.id)
      end
    end

    describe 'game_date' do
      let!(:latest_review) { create(:review, reviewer: reviewer, reviewee: reviewee, game_date: Time.current) }
      let!(:old_review) { create(:review, reviewer: reviewer, reviewee: reviewee, game_date: Time.current.ago(1.days)) }

      context 'sort=new_game' do
        before { get "/api/v1/users/#{reviewer.id}/reviews", params: { q: { sort: 'new_game' } } }
        it '試合日を基準に降順に並び替える' do
          expect(json['reviews'].first['id']).to eq(latest_review.id)
          expect(json['reviews'].last['id']).to eq(old_review.id)
        end
      end

      context 'sort=old_game' do
        before { get "/api/v1/users/#{reviewer.id}/reviews", params: { q: { sort: 'old_game' } } }
        it '試合日を基準に昇順に並び替える' do
          expect(json['reviews'].first['id']).to eq(old_review.id)
          expect(json['reviews'].last['id']).to eq(latest_review.id)
        end
      end
    end

    context 'sort=rating' do
      let!(:high_review) { create(:review, :high_review, reviewer: reviewer, reviewee: reviewee ) }
      let!(:low_review) { create(:review, :low_review, reviewer: reviewer, reviewee: reviewee ) }
      before { get "/api/v1/users/#{reviewer.id}/reviews", params: { q: { sort: 'rating' } } }
      it '評価点を基準に降順に並び替える' do
        expect(json['reviews'].first['id']).to eq(high_review.id)
        expect(json['reviews'].last['id']).to eq(low_review.id)
      end
    end
  end

  describe 'POST /api/v1/users/:user_id/reviews' do
    before { login_as(reviewer) }
    context '正常系' do
      before do
        post "/api/v1/users/#{reviewee.id}/reviews", headers: header, params: {
          review: { content: 'good', rate: 3.0, game_date: Time.current }
        }
      end

      it '２０１を返す' do
        expect(response.status).to eq(201)
      end

      it '作成したレビューを返す' do
        expect(json.length).to eq(1)
      end
    end

    context '異常系' do
      before do
        post "/api/v1/users/#{reviewee.id}/reviews", headers: header, params: {
          review: { content: 'good', rate: 3.0, game_date: Time.current }
        }
        post "/api/v1/users/#{reviewee.id}/reviews", headers: header, params: {
          review: { content: 'good', rate: 3.0, game_date: Time.current }
        }
      end

      it '４２２を返す' do
        expect(response.status).to eq(422)
      end

      it 'エラーメッセージを返す' do
        expect(json['errors']['game_date'].first).to eq('この試合日は既に存在します')
      end
    end
  end
end
