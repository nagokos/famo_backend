class Api::V1::Users::Current::ReviewsController < ApplicationController
  def index
    reviews = if current_user.reviewer?
                current_user.active_reviews
              else
                current_user.passive_reviews
              end
    render json: reviews, role: current_user.role
  end
end
