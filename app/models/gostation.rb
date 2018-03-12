class Gostation < ApplicationRecord
  has_many :checkins
  has_many :checkedin_users, through: :checkins, source: :user
end
