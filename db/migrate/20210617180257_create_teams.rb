class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.integer :kind, null: false, default: 0
      t.references :prefecture, null: false, foreign_key: true

      t.timestamps
    end
    add_index :teams, [:name, :prefecture_id], unique: true
  end
end
