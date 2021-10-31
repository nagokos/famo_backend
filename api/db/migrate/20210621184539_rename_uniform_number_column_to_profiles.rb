class RenameUniformNumberColumnToProfiles < ActiveRecord::Migration[6.1]
  def change
    rename_column :profiles, :uniform_number, :official_number
  end
end
