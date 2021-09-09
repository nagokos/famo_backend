class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar, :birth_date, :role, :introduction,
             :email, :activation_state
  has_one :profile

  def avatar
    if object.avatar.url
      "#{Aws::S3::Object.new(Rails.application.credentials.aws[:bucket], object.avatar.file.file.delete_prefix("/myapp/public/")).public_url}?#{Time.zone.now.to_i}"
    else
      'https://pics.prcm.jp/a508a977c6fa9/84540173/png/84540173.png'
    end
  end
end
