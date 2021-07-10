class Api::V1::UserSessionsController < Api::V1::BaseController
  def create
    User.authenticate(params[:email], params[:password]) do |user, failure_reason|
      if user && !failure_reason.present?
        token = user.create_token
        cookies[:token] = { value: token, expires: 1.month.from_now, secure: Rails.env.production?, httponly: true, same_site: 'Lax' }
        render json: user, status: :ok
      else
        case failure_reason
        when :invalid_login
          render json: { errors: { email: 'メールアドレスが間違っています' } }, status: :bad_request
        when :inactive
          render json: { errors: { key: 'inactive' } }, status: :bad_request
        when :invalid_password
          render json: { errors: { password: 'パスワードが間違っています' } }, status: :bad_request
        end
      end
    end
  end

  def destroy
    cookies.delete(:token)
    @current_user = nil
  end
end
