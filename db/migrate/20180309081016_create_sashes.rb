class CreateSashes < ActiveRecord::Migration[5.1]
  def change
    create_table :sashes do |t|
      t.timestamps null: false
    end
  end
end
