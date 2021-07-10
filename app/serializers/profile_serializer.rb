class ProfileSerializer < ActiveModel::Serializer
  attributes :position, :official_number, :practice_number, :career,
             :team, :prefecture, :group, :category, :league, :team_id, :group_id

  def team
    object.team.name
  end

  def prefecture
    {
      id: object.team.prefecture.id,
      name: object.team.prefecture.name
    }
  end

  def group
    object.group.name
  end

  def category
    {
      id: object.group.category.id,
      name: object.group.category.name,
    }
  end

  def league
    {
      id: object.group.category.league.id,
      name: object.group.category.league.name,
    }
  end
end
