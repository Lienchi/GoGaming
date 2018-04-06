class UserProduct < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :repairstore, optional: :true
end
