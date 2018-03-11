class RenamePathsTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :trips, :paths
  end
end
