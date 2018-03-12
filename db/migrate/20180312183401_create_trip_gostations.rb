class CreateTripGostations < ActiveRecord::Migration[5.1]
  def change
    create_table :trip_gostations do |t|
      t.integer :trip_id
      t.integer :gostation_id
      t.integer :user_id
      t.boolean :checkedin, default: false

      t.timestamps
    end
  end
end
