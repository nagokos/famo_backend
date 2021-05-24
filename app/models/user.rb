class User < ApplicationRecord
  before_save :email_downcase
  after_save :setup_activation, if: -> { email_changed? }

  authenticates_with_sorcery!

  EMAIL_FORMAT = /\A[a-zA-Z0-9_+-]+(.[a-zA-Z0-9_+-]+)*@([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]*\.)+[a-zA-Z]{2,}\z/i
  PASSWORD_FORMAT = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,}+\z/i

  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { maximum: 30 }
  validates :birth_date, presence: true, format: { with: /\d{4}-\d{2}-\d{2}/ }
  validates :avatar, presence: true
  validates :role, presence: true
  validates :introduction, length: { maximum: 400 }
  validates :email, uniqueness: true, presence: true, format: { with: EMAIL_FORMAT }
  validates :password, presence: true, length: { minimum: 8 }, format: { with: PASSWORD_FORMAT },
                       if: -> { new_record? || changes[:crypted_password] }
  validates :activation_token, uniqueness: true, allow_nil: true

  enum role: { reviewer: 0, player: 1, admin: 2 }

  private

  def email_downcase
    self.email = email.downcase
  end

  def set_activation_token_exp
    self.activation_token_expires_at = Time.zone.now.since(1.day)
  end
end
