class TripGostation < ApplicationRecord
  belongs_to :trip
  belongs_to :gostation
  belongs_to :user
end
