class AddGostationsToTrips < ActiveRecord::Migration[5.1]
  def change
    add_column :trips, :gostations, :text
  end
end
