class Api::V1::Users::CurrentsController < Api::V1::BaseController
  before_action :required_login, only: %i[update destroy]
  before_action :check_activation, only: %i[update destroy]

  def show
    render json: current_user
  end

  def update
    current_user.assign_attributes(user_params)
    if current_user.save
      render json: current_user
    else
      render json: { errors: current_user.errors, message: 'フォームに不備があります' }, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.destroy!
    cookies.delete(:token)
    @current_user = nil
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :avatar, :email, :introduction)
  end
end
