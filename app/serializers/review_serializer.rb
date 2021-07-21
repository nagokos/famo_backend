class ReviewSerializer < ActiveModel::Serializer
  attributes :rate, :content, :game_date
  belongs_to :reviewer, if: -> { instance_options[:role] != 'reviewer' }
  belongs_to :reviewee, if: -> { instance_options[:role] != 'player' }

  def rate
    object.rate.to_i
  end

  def game_date
    object.game_date.strftime("%Y/%m/%d")
  end

  def reviewer
    {
      id: object.reviewer.id,
      full_name: "#{object.reviewer.last_name} #{object.reviewer.first_name}",
      avatar: object.reviewer.avatar,
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
