class Api::V1::Users::GameDatesController < ApplicationController
  def index
    user = User.find(params[:user_id])
    game_dates = user.filter_reviews_dates.map(&:game_date).map(&:strftime)
    render json: { reviews: game_dates }
  end
end
