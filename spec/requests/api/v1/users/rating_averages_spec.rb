require 'rails_helper'

RSpec.describe "Api::V1::Users::RatingAverages", type: :request do
  let!(:reviewer) { create(:user) }
  let!(:reviewee) { create(:user, :player) }
  before { create_list(:review, 10, reviewer: reviewer, reviewee: reviewee) }
  describe "GET /api/v1/users/:user_id/rating_average" do
    it '評価点の平均を返す' do
      get "/api/v1/users/#{reviewer.id}/rating_average"
      expect(json).to_not eq(0)
    end

    context 'レビューが一件もない' do
      before { get "/api/v1/users/#{reviewee.id}/rating_average" }
      it '０を返す' do
        expect(json).to eq(0)
      end
    end
  end
end
