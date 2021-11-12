require 'rails_helper'

RSpec.describe "Api::V1::Users::Current::GameDates", type: :request do
  describe "GET /api/v1/users/current/game_dates" do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user, :player) }
    let!(:review) { create(:review, reviewer: user, reviewee: other_user, game_date: Time.current) }
    before do
      login_as(user)
      get '/api/v1/users/current/game_dates'
    end
    it '試合日を返すこと' do
      expect(json['dates'].first).to eq(review.game_date.strftime)
    end
  end
end
