class Api::V1::Users::Current::ReviewsController < ApplicationController
  def index
    reviews = current_user.filter_reviews.desc
    render json: reviews, role: current_user.role
  end
end
