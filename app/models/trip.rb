class Trip < ApplicationRecord
  has_many :challenges, dependent: :destroy
  has_many :challenged_users, through: :challenges, source: :user
end
