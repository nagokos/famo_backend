class Api::V1::PasswordResetsController < Api::V1::BaseController
  def create
    if (user = User.find_by(email: params[:email]))
      user.deliver_reset_password_instructions!
    else
      render json: { errors: { email: 'ユーザーが見つかりませんでした' }, message: 'フォームに不備があります' }, status: :not_found
    end
  end

  def edit
    token = params[:id]
    user = User.load_from_reset_password_token(params[:id]) do |user, failure_reason|
      if user && !failure_reason
        cookies[:reset_token] = { value: token, path: account_password_reset_path, expires: 5.minutes.from_now, secure: Rails.env.production?, same_site: 'Lax' }
        redirect_to account_password_reset_path
      else
        case failure_reason
        when :invalid_token
          render json: { message: '再設定メールの取得からやり直してください' }, status: :bad_request
        when :user_not_found
          render json: { message: '再設定済み又はURLが無効です' }, status: :bad_request
        when :token_expired
          render json: { message: '再設定メールの取得からやり直してください' }, status: :bad_request
        end
      end
    end
  end

  def update
    token = params[:id]
    if (user = User.load_from_reset_password_token(params[:id]))
      user.password_confirmation = params[:user][:password_confirmation]
      if user.change_password(params[:user][:password])
        cookies[:reset_token] = { value: token, path: account_password_reset_path, expires: 50.years.ago }
        head :ok
      else
        render json: { errors: user.errors, message: 'フォームに不備があります' }, status: :unprocessable_entity
      end
    else
      render json: { message: '再設定メールの取得からやり直してください' }, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
