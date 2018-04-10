class Addsitephotocolumn < ActiveRecord::Migration[5.1]
  def change
    add_column :sites, :photo, :string
  end
end
