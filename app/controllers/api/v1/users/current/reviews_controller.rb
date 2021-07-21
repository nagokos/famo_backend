class Api::V1::Users::Current::ReviewsController < ApplicationController
  def index
    if current_user.reviewer?
      reviews = current_user.active_reviews
    else
      reviews = current_user.passive_reviews
    end
    render json: reviews, role: current_user.role
  end
end
