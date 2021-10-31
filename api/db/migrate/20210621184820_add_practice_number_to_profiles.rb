class AddPracticeNumberToProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :practice_number, :integer, after: :official_number
  end
end
