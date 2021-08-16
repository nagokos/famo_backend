class Api::V1::Users::Current::RatingAveragesController < Api::V1::BaseController
  def show
    average = current_user.active_reviews.average(:rate)
    if average.nil?
      average = 0
    else
      average = format('%10.1f', average).strip
    end
    render json: average
  end
end
