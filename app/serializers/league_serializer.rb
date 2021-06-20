class LeagueSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :categories

  class CategorySerializer < ActiveModel::Serializer
    attributes :id, :name
    has_many :groups

    class GroupSerializer < ActiveModel::Serializer
      attributes :id, :name
    end
  end
end
