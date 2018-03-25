class CreateFriendlystores < ActiveRecord::Migration[5.1]
  def change
    create_table :friendlystores do |t|
      t.string :name
      t.text :description
      t.float :latitude
      t.float :longitude
      t.text :discount
      t.text :address
      t.text :source_title
      t.text :source_url
      t.string :open_time
      t.text :main_photo
      t.timestamps
    end
  end
end
