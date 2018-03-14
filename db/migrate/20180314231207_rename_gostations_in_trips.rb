class RenameGostationsInTrips < ActiveRecord::Migration[5.1]
  def change
    rename_column :trips, :gostations, :gostations_index
  end
end
