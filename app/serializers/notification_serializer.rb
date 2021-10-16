class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :action, :checked

  belongs_to :visitor
end
