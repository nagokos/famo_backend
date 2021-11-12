require 'rails_helper'

RSpec.describe "Api::V1::Users::Current::RatingAverages", type: :request do
  describe "GET /api/v1/users/current/rating_averages" do
    let!(:reviewer) { create(:user) }
    let!(:reviewee) { create(:user) }
    before { login_as(reviewer) }

    it '評価点の平均を返す' do
      create(:review, reviewer: reviewer, reviewee: reviewee, rate: 3.0)
      get '/api/v1/users/current/rating_averages'
      expect(json).to eq(3.0)
    end

    context 'レビューが一件もない' do
      it '０を返す' do
        get '/api/v1/users/current/rating_averages'
        expect(json).to eq(0)
      end
    end
  end
end
