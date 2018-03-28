class Adddescriptiontotrip < ActiveRecord::Migration[5.1]
  def change
    add_column :trips, :description, :string
    add_column :trips, :image, :string
  end
end
