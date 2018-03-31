class Users::RegistrationsController < Devise::RegistrationsController
  after_action :create_trip_gostation, only: :create
  def create
    @user = build_resource # Needed for Merit
    super
  end

  def update
    @user = resource # Needed for Merit
    super
  end

  def create_trip_gostation

    Trip.all.each do |t|
      t.gostations_index.each do |gid|
        TripGostation.create!(
            user_id: @user.id,
            trip_id: t.id,
            gostation_id: gid,
            status: false
        )
      end
    end
  end
end