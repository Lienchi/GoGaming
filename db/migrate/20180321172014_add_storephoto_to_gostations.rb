class AddStorephotoToGostations < ActiveRecord::Migration[5.1]
  def change
    add_column :gostations, :StorePhoto, :text
  end
end
