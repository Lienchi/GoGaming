class Trip < ApplicationRecord
  has_many :challenges, dependent: :destroy
  has_many :challenged_users, through: :challenges, source: :user

  has_many :trip_gostations
  has_many :gostations, through: :trip_gostations, source: :gostation


end
