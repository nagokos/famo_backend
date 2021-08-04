class SearchUsersForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :league_id, :integer
  attribute :category_id, :integer
  attribute :group_id, :integer
  attribute :position, :string
  attribute :team_id, :integer

  def search
    relation = User.cache_profile

    relation = relation.joins(profile: { group: { category: :league } }).merge(League.where(id: league_id)) if league_id.present?
    relation = relation.joins(profile: { group: :category }).merge(Category.where(id: category_id)) if category_id.present?
    relation = relation.joins(profile: :group).merge(Group.where(id: group_id)) if group_id.present?

    relation = relation.merge(Profile.where(position: position)) if position.present?
    relation = relation.merge(Profile.where(team_id: team_id)) if team_id.present?

    relation
  end
end
