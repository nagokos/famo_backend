class Api::V1::Users::RatingAveragesController < Api::V1::BaseController
  def show
    user = User.find(params[:user_id])
    average = user.active_reviews.average(:rate)
    if average.nil?
      average = 0
    else
      average = format('%10.1f', average).strip
    end
    render json: average
  end
end
