class Addcolumntouserproduct < ActiveRecord::Migration[5.1]
  def change
    add_column :user_products, :user_id, :integer
    add_column :user_products, :product_id, :integer
  end
end
