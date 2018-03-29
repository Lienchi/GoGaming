class Addimagetocomment < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :image, :string
  end
end
