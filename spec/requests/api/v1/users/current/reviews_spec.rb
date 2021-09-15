require 'rails_helper'

RSpec.describe "Api::V1::Users::Current::Reviews", type: :request do
  let!(:header) { { 'X-Requested-With': 'XMLHttpRequest' } }
  let!(:reviewer) { create(:user) }
  let!(:reviewee) { create(:user, :player_student) }
  before { login_as(reviewer) }

  describe "GET /api/v1/users/current/reviews" do
    context 'sort=created' do
      let!(:latest_review) { create(:review, reviewer: reviewer, reviewee: reviewee, created_at: Time.current) }
      let!(:old_review) { create(:review, reviewer: reviewer, reviewee: reviewee, created_at: Time.current.ago(1.days)) }
      before { get '/api/v1/users/current/reviews', params: { q: { sort: 'created' } } }

      it '作成日を基準に並び替える' do
        expect(json['reviews'].first['id']).to eq(latest_review.id)
        expect(json['reviews'].last['id']).to eq(old_review.id)
      end
    end

    describe 'game_date' do
      let!(:latest_review) { create(:review, reviewer: reviewer, reviewee: reviewee, game_date: Time.current) }
      let!(:old_review) { create(:review, reviewer: reviewer, reviewee: reviewee, game_date: Time.current.ago(1.days)) }

      context 'sort=new_game' do
        before { get '/api/v1/users/current/reviews', params: { q: { sort: 'new_game' } } }
        it '試合日を基準に降順に並び替える' do
          expect(json['reviews'].first['id']).to eq(latest_review.id)
          expect(json['reviews'].last['id']).to eq(old_review.id)
        end
      end

      context 'sort=old_game' do
        before { get '/api/v1/users/current/reviews', params: { q: { sort: 'old_game' } } }
        it '試合日を基準に昇順に並び替える' do
          expect(json['reviews'].first['id']).to eq(old_review.id)
          expect(json['reviews'].last['id']).to eq(latest_review.id)
        end
      end

      context '試合日を指定' do
        before { get '/api/v1/users/current/reviews', params: { q: { sort: 'created', game_date: Time.current.strftime('%F') } } }
        it '指定した試合日のレビューを返す' do
          expect(json['reviews'].pluck('id')).to include(latest_review.id)
          expect(json['reviews'].pluck('id')).to_not include(old_review.id)
        end
      end
    end

    context 'sort=rating' do
      let!(:high_review) { create(:review, :high_review, reviewer: reviewer, reviewee: reviewee) }
      let!(:low_review) { create(:review, :low_review, reviewer: reviewer, reviewee: reviewee) }
      before { get '/api/v1/users/current/reviews', params: { q: { sort: 'rating' } } }

      it '評価点を基準に降順に並び替える' do
        expect(json['reviews'].first['id']).to eq(high_review.id)
        expect(json['reviews'].last['id']).to eq(low_review.id)
      end
    end
  end

  describe 'PATCH /api/v1/users/current/reviews/:id' do
    let!(:review) { create(:review, reviewer: reviewer, reviewee: reviewee) }
    before { patch "/api/v1/users/current/reviews/#{review.id}", headers: header, params: { review: { privacy: 'player_only' } } }

    it 'レビューを返す' do
      expect(json.length).to eq(1)
    end
  end

  describe 'DELETE /api/v1/users/current/reviews/:id' do
    let!(:review) { create(:review, reviewer: reviewer, reviewee: reviewee) }
    before { delete "/api/v1/users/current/reviews/#{review.id}", headers: header }

    it '２０４を返す' do
      expect(response.status).to eq(204)
    end
  end
end
