class UserMailer < ApplicationMailer
  def activation_needed_email(user)
    @user = user
    @url  = edit_api_v1_account_activation_url(@user.activation_token)
    mail(to: user.email, subject: '認証メール送信のお知らせ')
  end

  def activation_success_email(user)
    @user = user
    @url = Settings.url.root
    mail(to: user.email, subject: 'アカウント認証のお知らせ')
  end

  def reset_password_email(user)
    @user = user
    @url = edit_api_v1_password_reset_url(@user.reset_password_token)
    mail(to: user.email, subject: '再設定メール送信のお知らせ')
  end
end
