class User < ApplicationRecord
  after_create :create_trip_gostation, :initialize_points
  
  mount_uploader :avatar, PhotoUploader
  has_merit

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]


  #after_save :create_trip_gostation_record, on: :create

  has_many :checkins, dependent: :destroy
  has_many :checkedin_gostations, through: :checkins, source: :gostation

  has_many :challenges, dependent: :destroy
  has_many :challenged_trips, through: :challenges, source: :trip

  has_many :trip_gostations

  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  has_many :comments, dependent: :destroy
  has_many :commented_trips, through: :comments, source: :trip

  has_many :user_products
  has_many :products, through: :user_products, source: :product

  def admin?
    self.role == "admin"
  end
   
  def following?(user)
    self.followings.include?(user)
  end
  
  def check_avatar(user)
    if user.avatar.nil?
      "avatar.svg"
    else
      user.avatar
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] &&  session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  
  def self.from_omniauth(auth)
    #where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    #  user.provider = auth.provider
    #  user.uid      = auth.uid
    #  user.email    = auth.info.email
    #  user.name     = auth.info.name
    #  user.password = Devise.friendly_token[0,20]
      #user.avatar   = auth.info.image
    #end
    # Case 1: Find existing user by facebook uid
    user = User.find_by_uid( auth.uid )
    if user
      user.fb_token = auth.credentials.token
      user.save!
      return user
    end

    # Case 2: Find existing user by email
    existing_user = User.find_by_email( auth.info.email )
    if existing_user
      existing_user.uid = auth.uid
      existing_user.fb_token = auth.credentials.token
      existing_user.save!
      return existing_user
    end

    # Case 3: Create new password
    user = User.new
    user.uid = auth.uid
    user.fb_token = auth.credentials.token
    user.email = auth.info.email
    user.name = auth.info.name
    user.password = Devise.friendly_token[0,20]
    user.save!
    return user
  end

  def getUserLevel()
    if self.experience > 100000
      return 9
    elsif self.experience > 50000
      return 8
    elsif self.experience > 30000
      return 7
    elsif self.experience > 10000
      return 6
    elsif self.experience > 6000
      return 5
    elsif self.experience > 3000
      return 4
    elsif self.experience > 1000
      return 3
    elsif self.experience > 500
      return 2
    else
      return 1
    end
  end

  def create_trip_gostation
    Trip.all.each do |t|
      t.gostations_index.each do |gid|
        TripGostation.create!(
            user_id: self.id,
            trip_id: t.id,
            gostation_id: gid,
            status: false
        )
      end
    end
  end

  def initialize_points
    self.add_points(10, category: 'gostation')
    self.experience += 10
    self.save
  end
  
end
