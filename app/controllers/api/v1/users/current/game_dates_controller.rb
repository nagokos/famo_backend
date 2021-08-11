class Api::V1::Users::Current::GameDatesController < ApplicationController
  def index
    game_dates = current_user.filter_reviews_dates.map(&:game_date).map(&:strftime)
    render json: { reviews: game_dates }
  end
end
