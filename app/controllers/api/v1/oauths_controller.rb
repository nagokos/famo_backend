class Api::V1::OauthsController < Api::V1::BaseController
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    return redirect_to Settings.url.root if params[:error].present?

    if (user = login_from(provider))
      cookies[:login] = { value: 1, expires: 1.minutes.from_now }
    else
      user = build_from(provider)
      user.authentications.build(provider: provider, uid: @user_hash[:uid])
      return redirect_to Settings.url.login if set_email_from_line(user, provider) || check_email(user)

      user.save(validate: false)
      cookies[:signup] = { value: 1, expires: 1.minutes.from_now }
    end
    set_token(user)
    redirect_to Settings.url.profile
  end

  private

  def set_email_from_line(user, provider)
    return unless provider == 'line'

    decoded_id_token = JWT.decode(@access_token.params['id_token'], @provider.secret)
    if decoded_id_token.first['email'].present?
      user.email = decoded_id_token.first['email']
      false
    else
      cookies[:email_blank] = { value: 1, expires: 1.minutes.from_now }
      true
    end
  end

  def check_email(user)
    return unless User.exists?(email: user.email)

    cookies[:email_taken] = { value: 1, expires: 1.minutes.from_now }
    true
  end

  def set_token(user)
    token = user.create_token
    cookies[:token] = { value: token, expires: 1.month.from_now, secure: Rails.env.production?, httponly: true, same_site: 'Lax' }
  end
end
