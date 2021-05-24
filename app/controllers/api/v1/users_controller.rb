class Api::V1::UsersController < Api::V1::BaseController
  def create
    user = User.new(user_params)
    if user.save
      head :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def active
    if (user = User.load_from_activation_token(params[:id]))
      user.activate!
      redirect_to root_path
    else
      render json: { message: '認証済み又はリンクの有効期限が切れています' }, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :avatar, :email, :birth_date, :role, :introduction, :password)
  end
end
