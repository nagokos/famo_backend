class Api::V1::ReviewsController < ApplicationController
  def index
    reviews = Review.not_player.conditions_shuffle
    render json: reviews
  end
end
