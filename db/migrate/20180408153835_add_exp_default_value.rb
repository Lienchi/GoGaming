class AddExpDefaultValue < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :experience, :integer, :default => 0
  end
end
