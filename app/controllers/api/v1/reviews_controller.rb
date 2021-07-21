class Api::V1::ReviewsController < ApplicationController
  def index
    reviews = Review.where.not(privacy: 'player_only').order('RAND()').limit(4)
    render json: reviews
  end
end
