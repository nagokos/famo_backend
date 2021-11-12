class RemoveColumnKindToTeams < ActiveRecord::Migration[6.1]
  def change
    remove_column :teams, :kind
  end
end
