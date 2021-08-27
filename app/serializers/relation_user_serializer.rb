class RelationUserSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar, :role
  belongs_to :profile
end
