class CreateRepairstores < ActiveRecord::Migration[5.1]
  def change
    create_table :repairstores do |t|
      t.string :name
      t.string :address
      t.string :telephone
      t.string :officehours
      t.string :repairhours
      t.timestamps
    end
  end
end
