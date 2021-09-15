class Api::V1::Users::GameDatesController < Api::V1::BaseController
  def index
    user = User.find(params[:user_id])
    game_dates = user.role_and_game_date_reviews.published.map(&:game_date).map(&:strftime)
    render json: { dates: game_dates }
  end
end
