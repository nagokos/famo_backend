class Api::V1::Users::ReviewsController < Api::V1::BaseController
  before_action :required_login, only: %i[create]
  before_action :check_activation, only: %i[create]

  def index
    user = User.find(params[:user_id])
    if user.reviewer?
      reviews = user.active_reviews.where.not(privacy: 'player_only')
    else
      reviews = user.passive_reviews.where.not(privacy: 'player_only')
    end
    render json: reviews, role: user.role
  end

  def create
    reviewee = User.find(params[:user_id])
    review = current_user.active_reviews.build(review_params)
    review.reviewee_id = reviewee.id
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
end
