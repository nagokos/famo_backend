class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar, :birth_date, :role, :introduction,
             :email, :activation_state
  has_one :profile
end
