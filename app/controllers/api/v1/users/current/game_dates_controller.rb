class Api::V1::Users::Current::GameDatesController < Api::V1::BaseController
  def index
    game_dates = current_user.role_and_game_date_reviews.map(&:game_date).map(&:strftime)
    render json: { dates: game_dates }
  end
end
