class ChangeColumnUserIdToProfiles < ActiveRecord::Migration[6.1]
  def up
    change_column :profiles, :user_id, :string
  end

  def down
    change_column :profiles, :user_id, :integer
  end
end
