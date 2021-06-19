class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :position, null: false
      t.integer :uniform_number, null: false
      t.string :career, null: false
      t.references :user, null: false, fereign_key: true
      t.references :group, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
