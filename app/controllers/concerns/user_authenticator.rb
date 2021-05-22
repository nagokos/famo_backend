module UserAuthenticator
  extend ActiveSupport::Concern
  require 'jwt'

  SECRET_KEY_BASE = Rails.application.secrets.secret_key_base

  def create_token(user)
    preload = { user_id: user.id, exp: 1.month.from_now.to_i }
    encode(preload)
  end

  def current_user
    return unless cookies[:token].present?

    payload = decode(cookies[:token])
    @current_user ||= User.find_by(id: payload['user_id'])
  end

  def require_login
    return if current_user

    render json: { message: 'ログインしてください' }, status: :unauthorized
  end

  private

  def encode(preload)
    JWT.encode(preload, SECRET_KEY_BASE, 'HS256')
  end

  def decode(encoded_token)
    JWT.decode(encoded_token, SECRET_KEY_BASE, true, algorithm: 'HS256').first
  end
end
