class Users::RegistrationsController < Devise::RegistrationsController
  after_action :create_trip_gostation, only: :create
  before_action :configure_permitted_parameters
 

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
    user_params.permit(:name,
    :email, :password, :password_confirmation, :avatar)
    end
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
   user_params.permit(:name,
    :email, :password, :password_confirmation, :current_password, :avatar)
    end
  end

 




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