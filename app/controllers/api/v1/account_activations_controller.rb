class Api::V1::AccountActivationsController < ApplicationController
  def create
    if (user = User.find_by(email: params[:email]))
      if !user.activation_token.nil?
        user.setup_activation
        if user.save
          UserMailer.activation_needed_email(user).deliver_now
          head :ok
        else
          render json: { email: '送信に失敗しました。もう一度お試しください。' }, status: :bad_request
        end
      else
        render json: { email: 'このメールアドレスは認証済みです' }, status: :bad_request
      end
    else
      render json: { email: 'ユーザーが見つかりませんでした' }, status: :bad_request
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
        when :user_not_found
          render json: { message: '既に認証済み又はURLが無効です' }, status: :bad_request
        when :token_expired
          render json: { message: '有効期限切れです' }, status: :bad_request
        end
      end
    end
  end
end
