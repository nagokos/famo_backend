class RenameCarrerColumnToProfiles < ActiveRecord::Migration[6.1]
  def change
    rename_column :profiles, :carrer, :career
  end
end
