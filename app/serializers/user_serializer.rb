class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar, :birth_date, :role, :introduction,
             :email, :activation_state
  has_one :profile

  def avatar
    if object.avatar.url
      "https://#{Rails.application.credentials.aws[:bucket]}.s3.ap-northeast-1.amazonaws.com#{object.avatar.url}"
    else
      'https://pics.prcm.jp/a508a977c6fa9/84540173/png/84540173.png'
    end
  end
end
