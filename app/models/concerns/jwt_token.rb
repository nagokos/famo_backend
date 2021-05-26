module JwtToken
  extend ActiveSupport::Concern

  SECRET_KEY_BASE = Rails.application.secrets.secret_key_base

  class_methods do
    def decode(encoded_token)
      JWT.decode(encoded_token, SECRET_KEY_BASE, true, algorithm: 'HS256').first
    end
  end

  def create_token
    preload = { user_id: id, exp: 1.month.from_now.to_i }
    encode(preload)
  end

  private

  def encode(preload)
    JWT.encode(preload, SECRET_KEY_BASE, 'HS256')
  end
end
