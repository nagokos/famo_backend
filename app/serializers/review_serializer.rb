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

  def reviewer
    {
      id: object.reviewer_id.nil? ? '' : object.reviewer.id,
      full_name: object.reviewer_id.nil? ? '退会したユーザー' : "#{object.reviewer.last_name} #{object.reviewer.first_name}",
      avatar: object.reviewer_id.nil? ? 'https://pics.prcm.jp/a508a977c6fa9/84540173/png/84540173.png' : object.reviewer.avatar
    }
  end

  def reviewee
    {
      id: object.reviewee.id,
      full_name: "#{object.reviewee.last_name} #{object.reviewee.first_name}",
      avatar: object.reviewee.avatar,
      team: "#{object.reviewee.profile.team.name}(#{object.reviewee.profile.team.prefecture.name})",
      position: object.reviewee.profile.position
    }
  end
end
