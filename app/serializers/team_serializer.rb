class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :kind, :prefecture_id
end
