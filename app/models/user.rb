class User < ApplicationRecord
  has_merit

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :checkins, dependent: :destroy
  has_many :checkedin_gostations, through: :checkins, source: :gostation

  has_many :challenges, dependent: :destroy
  has_many :challenged_trips, through: :challenges, source: :trip

  def admin?
    self.role == "admin"
  end
end
