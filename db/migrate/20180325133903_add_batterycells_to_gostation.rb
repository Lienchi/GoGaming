class AddBatterycellsToGostation < ActiveRecord::Migration[5.1]
  def change
    add_column :gostations, :BatteryCells, :integer
  end
end
