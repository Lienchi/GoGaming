class CreateSites < ActiveRecord::Migration[5.1]
  def change
    create_table :sites do |t|
      t.string "name"
      t.text "description"
      t.float "latitude"
      t.float "longitude"
      t.text "photo"
      t.integer "trip_id"

      t.timestamps
    end
  end
end
