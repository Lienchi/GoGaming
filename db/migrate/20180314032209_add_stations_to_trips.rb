class AddStationsToTrips < ActiveRecord::Migration[5.1]
  def change
    add_column :trips, :stations, :integer, array: true, default: []
  end
end
