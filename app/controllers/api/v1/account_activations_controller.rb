class Api::V1::AccountActivationsController < Api::V1::BaseController
  def create
    if (user = User.find_by(email: params[:email]))
      if !user.activation_token.nil?
        user.setup_activation
        if user.save
          UserMailer.activation_needed_email(user).deliver_now
          head :ok
        else
          render json: { errors: { email: '送信に失敗しました。もう一度お試しください。' } }, status: :bad_request
        end
      else
        render json: { errors: { email: 'アカウントは認証済みです' } }, status: :bad_request
      end
    else
      render json: { errors: { email: 'ユーザーが見つかりませんでした' } }, status: :bad_request
    end
  end

  def edit
    User.load_from_activation_token(params[:id]) do |user, failure_reason|
      if user && !failure_reason.present?
        user.activate_attributes
        token = user.create_token
        cookies[:token] = { value: token, expires: 1.month.from_now, secure: Rails.env.production?, httponly: true, same_site: 'Lax' }
        cookies[:activation] = { value: 1, expires: 1.minutes.from_now }
        redirect_to root_path
      else
        case failure_reason
        when :invalid_token
          cookies[:activation] = { value: 2, expires: 1.minutes.from_now }
          redirect_to root_path
        when :user_not_found
          cookies[:activation] = { value: 3, expires: 1.minutes.from_now }
          redirect_to root_path
        when :token_expired
          cookies[:activation] = { value: 2, expires: 1.minutes.from_now }
          redirect_to root_path
        end
      end
    end
  end
end
