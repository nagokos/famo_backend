class Api::V1::RelationshipsController < Api::V1::BaseController
  before_action :required_login, only: %i[create destroy]
  before_action :check_activation, only: %i[create destroy]

  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    head :created
  rescue ActiveRecord::RecordInvalid
    render json: { message: 'すでにフォローしています' }, status: :bad_request
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    head :ok
  end

  def check
    user = User.find(params[:user_id])
    boolean = current_user.follow?(user)
    render json: { status: boolean }
  end
end
