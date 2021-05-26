module UserAuthenticator
  extend ActiveSupport::Concern
  require 'jwt'

  def current_user
    return unless cookies[:token].present?

    payload = User.decode(cookies[:token])
    @current_user ||= User.find_by(id: payload['user_id'])
  end

  def require_login
    return if current_user

    render json: { message: 'ログインしてください' }, status: :unauthorized
  end
end
