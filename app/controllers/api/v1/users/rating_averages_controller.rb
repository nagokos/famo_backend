class Api::V1::Users::RatingAveragesController < Api::V1::BaseController
  def index
    user = User.find(params[:user_id])
    average = user.active_reviews.average(:rate)
    average = if average.nil?
                0
              else
                format('%10.1f', average).strip
              end
    render json: average
  end
end
