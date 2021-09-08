module UserAuthenticator
  extend ActiveSupport::Concern

  def current_user
    return unless cookies[:token].present?

    payload = User.decode(cookies[:token])
    @current_user ||= User.find_by(id: payload['user_id'])
  end
end
