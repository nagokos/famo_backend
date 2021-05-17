class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render head :ok
    else
      render json: user.errors, status: :bad_request
    end
  end

  def update; end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :avatar, :email, birth_date, :role, :introduction,
                                 :password, :password_confirmation)
  end
end
