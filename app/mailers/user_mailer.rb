class UserMailer < ApplicationMailer
  def activation_needed_email
    @greeting = 'Hi'

    mail to: 'to@example.org'
  end

  def activation_success_email
    @greeting = 'Hi'

    mail to: 'to@example.org'
  end
end
