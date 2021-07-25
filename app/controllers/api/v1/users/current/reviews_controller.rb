class Api::V1::Users::Current::ReviewsController < Api::V1::BaseController
  before_action :required_login, only: %i[destroy]
  before_action :check_activation, only: %i[destroy]

  def index
    reviews = current_user.filter_reviews.desc
    render json: reviews, role: current_user.role
  end
end
