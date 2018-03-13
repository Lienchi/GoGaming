class Removecolumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :challenges, :status
  end
end
