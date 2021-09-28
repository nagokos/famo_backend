class Api::V1::ReviewsController < Api::V1::BaseController
  def index
    reviews = Review.joins(:reviewee).cache_profile.open.require_reviewer.conditions_shuffle.merge(User.where(role: 'player'))
    render json: reviews, include: '**'
  end
end
