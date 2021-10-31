class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :rate, :content, :game_date, :privacy, :created_at
  belongs_to :reviewer
  belongs_to :reviewee

  def rate
    format('%10.1f', object.rate).strip
  end

  def game_date
    object.game_date.strftime('%Y/%m/%d')
  end
end
