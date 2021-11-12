class ChangeDatatypeOfficialNumberAndPracticeNumberOfProfiles < ActiveRecord::Migration[6.1]
  def change
    change_column :profiles, :official_number, :string
    change_column :profiles, :practice_number, :string
  end
end
