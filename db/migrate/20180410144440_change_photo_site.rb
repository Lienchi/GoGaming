class ChangePhotoSite < ActiveRecord::Migration[5.1]
  def change
    change_column :sites, :photo, :string
  end
end
