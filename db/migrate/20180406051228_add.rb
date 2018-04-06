class Add < ActiveRecord::Migration[5.1]
  def change
    add_column :user_products, :repairstore_id, :integer
  end
end
