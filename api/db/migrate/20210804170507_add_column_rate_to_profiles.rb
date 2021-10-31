class AddColumnRateToProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :rate, :decimal, :precision => 3, :scale => 2, default: 0, null: false
  end
end
