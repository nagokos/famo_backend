class Profile < ApplicationRecord
  belongs_to :group
  belongs_to :team
  belongs_to :user

  validates :position, presence: true
  validates :uniform_number, presence: true
end
