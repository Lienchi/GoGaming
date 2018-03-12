class CreateGostations < ActiveRecord::Migration[5.1]
  def change
    create_table :gostations do |t|
      t.string :LocName
      t.float :Latitude
      t.float :Longitude
      t.string :ZipCode
      t.text :Address
      t.string :District
      t.string :City
      t.string :AvailableTime
      t.timestamps
    end
  end
end
