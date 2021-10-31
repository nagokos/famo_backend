class Group < ApplicationRecord
  belongs_to :category
  has_many :profiles, dependent: :restrict_with_exception
end
