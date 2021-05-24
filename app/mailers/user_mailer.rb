class UserMailer < ApplicationMailer
  def activation_needed_email(user)
    @user = user
    @url  = active_api_v1_user_url(@user.activation_token)
    mail(to: user.email, subject: 'Welcome to My Awesome Site')
  end

  def activation_success_email(user)
    @user = user
    @url = root_url
    mail(to: user.email, subject: '認証に成功しました')
  end
end
