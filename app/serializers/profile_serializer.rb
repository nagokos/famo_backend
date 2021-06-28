class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :position, :official_number, :practice_number, :team_id, :group_id
  belongs_to :team
  belongs_to :group

  class TeamSerializer < ActiveModel::Serializer
    attributes :name
    belongs_to :prefecture

    class PrefectureSerializer < ActiveModel::Serializer
      attributes :id, :name
    end
  end

  class GroupSerializer < ActiveModel::Serializer
    attributes :name
    belongs_to :category

    class CategorySerializer < ActiveModel::Serializer
      attributes :id, :name
      belongs_to :league

      class LeagueSerializer < ActiveModel::Serializer
        attributes :id, :name
      end
    end
  end
end
