class AddColumnProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :carrer, :string, after: :practice_number
  end
end
