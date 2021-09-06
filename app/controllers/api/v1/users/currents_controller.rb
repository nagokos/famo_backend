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

  def presigned_post
    current_user.update_column('avatar', params[:avatar])
    render json: { id: current_user.id, avatar_url: current_user.avatar.presigned_url }
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :birth_date, :email, :introduction)
  end
end
