module UserAuthenticator
  extend ActiveSupport::Concern
  require 'jwt'

  SECRET_KEY_BASE = Rails.application.secrets.secret_key_base

  def create_token(user)
    preload = { user_id: user.id, exp: 1.month_from.now.to_i }
    issue_token(preload)
  end

  def current_user
    return unless cookie[:token].present?
    encoded_token = cookie[:token]
    payload = decode(encoded_token)
    @current_user = User.find_by(id: payload['user_id'])
  end

  private

  def issue_token(preload)
    JWT.encode(preload, SECRET_KEY_BASE, 'HS256')
  end

  def decode(encoded_token)
    JWT.decode(encoded_token, SECRET_KEY_BASE, true, algorithm: 'HS256')
  end
end