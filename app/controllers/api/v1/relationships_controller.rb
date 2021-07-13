class Api::V1::RelationshipsController < ApplicationController
  before_action :required_login, only: %i[create destroy check]

  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    head :created
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
