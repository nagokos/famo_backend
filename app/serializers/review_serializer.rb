class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :rate, :content, :game_date, :privacy
  belongs_to :reviewer
  belongs_to :reviewee

  def rate
    object.rate.to_i
  end

  def game_date
    object.game_date.strftime('%Y/%m/%d')
  end
end
