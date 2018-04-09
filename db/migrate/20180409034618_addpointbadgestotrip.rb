class Addpointbadgestotrip < ActiveRecord::Migration[5.1]
  def change
    add_column :trips, :badge, :string
    add_column :trips, :points, :integer
  end
end
