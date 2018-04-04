class Addcolumntochallenge < ActiveRecord::Migration[5.1]
  def change
    add_column :challenges, :completetime, :float
  end
end
