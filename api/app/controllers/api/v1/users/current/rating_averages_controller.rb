class Api::V1::Users::Current::RatingAveragesController < Api::V1::BaseController
  def index
    average = current_user.active_reviews.average(:rate)
    average = if average.nil?
                0
              else
                format('%10.1f', average).strip
              end
    render json: average
  end
end
