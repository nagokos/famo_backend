class Category < ApplicationRecord
  belongs_to :league
  has_many :groups, dependent: :restrict_with_exception
end
