class Notification < ApplicationRecord
  belongs_to :visitor, class_name: 'User', optional: true
  belongs_to :visited, class_name: 'User', optional: true

  validates :notifiable_type, presence: true
  validates :action, presence: true

  enum notifiable_type: { review: 0 }
  enum action: { created: 0, like: 1, report: 2 }
end
