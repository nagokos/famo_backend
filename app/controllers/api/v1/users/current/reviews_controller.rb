class Api::V1::Users::Current::ReviewsController < Api::V1::BaseController
  before_action :check_login, only: %i[destroy]
  before_action :check_activation, only: %i[destroy]

  def index
    search_reviews_form = SearchReviewsForm.new(search_params)
    reviews = search_reviews_form.search(current_user)
    @pagy, reviews = pagy(reviews, items: 10)
    render json: reviews, include: '**'
  end

  def update
    review = current_user.active_reviews.find(params[:id])
    review.update!(review_params)
    render json: review
  end

  def destroy
    current_user.active_reviews.find(params[:id]).destroy!
  end

  private

  def review_params
    params.require(:review).permit(:privacy)
  end

  def search_params
    params[:q]&.permit(:sort, :game_date)
  end
end
