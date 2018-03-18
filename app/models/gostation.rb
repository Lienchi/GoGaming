class Gostation < ApplicationRecord
  has_many :checkins, dependent: :destroy
  has_many :checkedin_users, through: :checkins, source: :user

  has_many :trip_gostations
  has_many :trips, through: :trip_gostations, source: :trip

  def is_checkedin?(user)
    self.checkedin_users.include?(user)
  end
end
