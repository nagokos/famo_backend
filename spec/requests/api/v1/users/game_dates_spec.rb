require 'rails_helper'

RSpec.describe "Api::V1::Users::GameDates", type: :request do
  let!(:reviewer) { create(:user) }
  let!(:reviewee) { create(:user, :player) }
  before { create_list(:review, 10, reviewer: reviewer, reviewee: reviewee) }
  describe "GET /api/v1/users/:user_id/game_dates" do
    before { get "/api/v1/users/#{reviewee.id}/game_dates" }
    it '試合日を返す' do
      expect(json['dates']).to include(reviewer.active_reviews.first.game_date.strftime)
    end
  end
end
