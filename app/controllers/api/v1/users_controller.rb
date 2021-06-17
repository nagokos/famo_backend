class Api::V1::UsersController < Api::V1::BaseController
  def create
    user = User.new(user_params)
    user.activation_token_expires_at = Time.zone.now.since(1.day)
    if user.save
      head :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :avatar, :email, :birth_date, :password)
  end
end
