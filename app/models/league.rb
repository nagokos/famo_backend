class League < ApplicationRecord
  has_many :categories, dependent: :restrict_with_exception
end
