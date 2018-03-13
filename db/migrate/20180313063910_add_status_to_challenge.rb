class AddStatusToChallenge < ActiveRecord::Migration[5.1]
  def change
    add_column :challenges, :status, :boolean
  end
end
