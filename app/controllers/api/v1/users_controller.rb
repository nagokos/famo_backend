class Api::V1::UsersController < Api::V1::BaseController
  def create
    user = User.new(user_params)
    if user.save
      head :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :avatar, :email, :birth_date, :role, :introduction, :password)
  end
end
