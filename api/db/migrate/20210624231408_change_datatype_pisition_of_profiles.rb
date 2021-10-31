class ChangeDatatypePisitionOfProfiles < ActiveRecord::Migration[6.1]
  def change
    change_column :profiles, :position, :integer, null: false, default: 0
  end
end
