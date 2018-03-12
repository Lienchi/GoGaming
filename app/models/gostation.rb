class Gostation < ApplicationRecord
  has_many :checkins, dependent: :destroy
  has_many :checkedin_users, through: :checkins, source: :user
end
