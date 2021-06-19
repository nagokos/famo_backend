class Prefecture < ApplicationRecord
  has_many :teams, dependent: :restrict_with_exception
end
