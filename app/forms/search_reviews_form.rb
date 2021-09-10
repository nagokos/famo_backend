class SearchReviewsForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :sort, :string
  attribute :game_date, :date

  def search(user)
    relation = user.role_reviews

    relation = sort_change(relation)
    relation = relation.game_select_day(game_date) if game_date.present?

    relation
  end

  private

  def sort_change(relation)
    case sort
    when 'created'
      relation.desc
    when 'new_game'
      relation.game_desc
    when 'old_game'
      relation.game_asc
    when 'rating'
      relation.rating
    end
  end
end
