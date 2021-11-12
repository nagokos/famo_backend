class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :action, :checked, :notifiable_type

  belongs_to :visitor
end
