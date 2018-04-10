class Change < ActiveRecord::Migration[5.1]
  def change
    remove_column :sites, :photo
  end
end
