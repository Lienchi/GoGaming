class Renamecheckedin < ActiveRecord::Migration[5.1]
  def change
    rename_column :trip_gostations, :checkedin, :status
  end
end
