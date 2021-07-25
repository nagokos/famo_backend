class Api::V1::Users::Current::PasswordChangesController < ApplicationController
  def update
    if current_user.valid_password?(params[:current_password])
      current_user.assign_attributes(user_params)
      if current_user.save
        head :ok
      else
        render json: { errors: current_user.errors, message: 'フォームに不備があります' }, status: :unprocessable_entity
      end
    else
      render json: { errors: { current_password: '有効なパスワードを入力してください' }, message: 'フォームに不備があります' }, status: :not_found
    end
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
