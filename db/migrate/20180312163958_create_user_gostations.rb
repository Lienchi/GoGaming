class CreateUserGostations < ActiveRecord::Migration[5.1]
  def change
    create_table :user_gostations do |t|
      t.integer :user_id
      t.integer :gostation_id
      t.boolean :checkin

      t.timestamps
    end
  end
end
