class AddColumnToChallenge < ActiveRecord::Migration[5.1]
  def change
    add_column :challenges, :displaymodal, :boolean, :default => false
  end
end
