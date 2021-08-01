class RelationUserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :avatar, :role
  belongs_to :profile
end
