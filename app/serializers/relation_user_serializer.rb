class RelationUserSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar, :role
  belongs_to :profile

  def avatar
    if object.avatar.url
      "https://#{Rails.application.credentials.aws[:bucket]}.s3.ap-northeast-1.amazonaws.com#{object.avatar.url}"
    else
      'https://pics.prcm.jp/a508a977c6fa9/84540173/png/84540173.png'
    end
  end
end
