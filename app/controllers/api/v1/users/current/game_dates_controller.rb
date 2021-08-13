class Api::V1::Users::Current::GameDatesController < Api::V1::BaseController
  def index
    game_dates = current_user.filter_reviews_dates.map(&:game_date).map(&:strftime)
    render json: { reviews: game_dates }
  end
end
