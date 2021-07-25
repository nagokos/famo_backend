class Api::V1::Users::Current::ReviewsController < Api::V1::BaseController
  before_action :required_login, only: %i[destroy]
  before_action :check_activation, only: %i[destroy]

  def index
    reviews = current_user.filter_reviews.desc
    render json: reviews
  end

  def update
    review = current_user.active_reviews.find(params[:id])
    if review.update(review_params)
      render json: review
    else
      render json: { errors: review.errors, message: "もう一度選択してください" }
    end
  end

  def destroy
    current_user.active_reviews.find(params[:id]).destroy!
  end

  private

  def review_params
    params.require(:review).permit(:privacy)
  end
end
