class Api::V1::Users::ReviewsController < Api::V1::BaseController
  before_action :required_login, only: %i[create]
  before_action :check_activation, only: %i[create]

  def index
    user = User.find(params[:user_id])
    search_reviews_form = SearchReviewsForm.new(search_params)
    reviews = search_reviews_form.search(user).published
    @pagy, reviews = pagy(reviews)
    render json: reviews, include: '**'
  end

  def create
    reviewee = User.find(params[:user_id])
    review = current_user.active_reviews.build(review_params)
    review.reviewee = reviewee
    if review.save
      render json: review, status: :created
    else
      render json: { errors: review.errors, message: 'フォームに不備があります' }, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:rate, :content, :game_date, :privacy)
  end

  def search_params
    params[:q]&.permit(:sort, :game_date)
  end
end
