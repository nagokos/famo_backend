class Api::V1::ReviewsController < ApplicationController
  def index
    reviews = Review.joins(:reviewee).everyone.require_reviewer.conditions_shuffle.merge(User.where(role: 'player'))
    render json: reviews
  end
end
