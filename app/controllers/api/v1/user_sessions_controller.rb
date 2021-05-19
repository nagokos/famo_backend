class Api::V1::UserSessionsController < Api::V1::BaseController
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      token = create_token(user)
      cookies[:token] = { value: token, expires: 1.month.from_now, secure: Rails.env.production?, httponly: true, same_site: 'Lax' }
      render json: user
    else
      render json: { message: 'ログインに失敗しました' }, status: :bad_request
    end
  end

  def destroy; end
end
