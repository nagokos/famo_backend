class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :position, :official_number, :practice_number, :team_id, :group_id
end
