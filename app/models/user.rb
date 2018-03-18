class User < ApplicationRecord
  validates :following_id, uniqueness: {scope: :user_id}

  has_merit

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :checkins, dependent: :destroy
  has_many :checkedin_gostations, through: :checkins, source: :gostation

  has_many :challenges, dependent: :destroy
  has_many :challenged_trips, through: :challenges, source: :trip

  has_many :trip_gostations

  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  def admin?
    self.role == "admin"
  end
   
  def following?(user)
    self.followings.include?(user)
  end
  
end
