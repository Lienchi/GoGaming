class Trip < ApplicationRecord
  mount_uploader :image, TripUploader
  validates_length_of :name, :maximum => 6
  validates_presence_of :name, :image, :description
  has_many :challenges, dependent: :destroy
  has_many :challenged_users, through: :challenges, source: :user

  has_many :trip_gostations
  has_many :gostations, through: :trip_gostations, source: :gostation

  has_many :comments, dependent: :destroy
  has_many :commented_users, through: :comments, source: :user

  serialize :gostations_index
  
  def is_challenged?(user)
    self.challenged_users.include?(user)
  end
end
