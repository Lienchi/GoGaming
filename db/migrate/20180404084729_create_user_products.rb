class CreateUserProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :user_products do |t|

      t.timestamps
    end
  end
end
