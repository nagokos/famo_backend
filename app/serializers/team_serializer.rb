class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :kind, :prefecture_id

  def kind
    object.kind_i18n
  end
end
