class Group < ApplicationRecord
  belongs_to :category
  has_many :profiles
end
