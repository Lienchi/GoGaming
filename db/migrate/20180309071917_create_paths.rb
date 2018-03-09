class CreatePaths < ActiveRecord::Migration[5.1]
  def change
    create_table :paths do |t|
      t.string :name
    

      t.timestamps
    end
  end
end
