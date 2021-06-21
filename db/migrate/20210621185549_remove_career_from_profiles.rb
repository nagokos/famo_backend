class RemoveCareerFromProfiles < ActiveRecord::Migration[6.1]
  def change
    remove_column :profiles, :career, :string
  end
end
