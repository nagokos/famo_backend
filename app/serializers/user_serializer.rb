class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :avatar, :birth_date, :role, :introduction,
             :email, :activation

  def role
    object.role_i18n
  end

  def activation
    object.activation_state == 'active'
  end
end
