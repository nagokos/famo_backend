class Api::V1::LikesController < Api::V1::BaseController
  before_action :check_login, only: %i[create destroy]
  before_action :check_activation, only: %i[create destroy]

  def create
    review = Review.find(params[:review_id])
    current_user.like(review)
    head :created
  rescue ActiveRecord::RecordInvalid
    render json: { message: 'すでにいいねしています' }, status: :bad_request
  end

  def destroy
    review = Review.find(params[:review_id])
    current_user.unlike(review)
    head :ok
  end

  def check
    review = Review.find(params[:review_id])
    boolean = current_user.like?(review)
    render json: { status: boolean }
  end

  def count
    review = Review.find(params[:review_id])
    count = review.likes.count
    render json: { count: count }
  end
end
