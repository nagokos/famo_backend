class Api::V1::OauthsController < Api::V1::BaseController
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]

    return redirect_to root_path if params[:error].present?

    if user = login_from(provider)
      token = user.create_token
      cookies[:token] = { value: token, expires: 1.month.from_now, secure: Rails.env.production?, httponly: true, same_site: 'Lax' }
      return redirect_to profile_path
    end

    user = build_from(provider)
    user.authentications.build(provider: provider, uid: @user_hash[:uid])

    if provider == 'line'
      userData = JWT.decode(@access_token.params["id_token"], @provider.secret)
      if userData.first['email'].present?
        user.email = userData.first['email']
      else
        cookies[:error] = { value: 'email_blank', expires: 1.minutes.from_now }
        return redirect_to login_path
      end
    end

    if user.invalid? && user.errors.include?(:password) && !user.errors.include?(:email)
      user.save(validate: false)
      token = user.create_token
      cookies[:create] = { value: 'signup_user', expires: 1.minutes.from_now }
      cookies[:token] = { value: token, expires: 1.month.from_now, secure: Rails.env.production?, httponly: true, same_site: 'Lax' }
      redirect_to root_path
    else
      if user.errors.of_kind?(:email, :taken)
        cookies[:error] = { value: 'email_taken', expires: 1.minutes.from_now }
        redirect_to login_path
      else
        redirect root_path
      end
    end
  end
end
