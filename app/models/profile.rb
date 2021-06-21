class Profile < ApplicationRecord
  belongs_to :group
  belongs_to :team
  belongs_to :user

  validates :position, presence: true
  validates :official_number, presence: true, numericality: true
  validates :practice_number, numericality: true, allow_nil: true
end
