class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  

  private


  def authenticate_admin
    unless current_user.admin?
      flash[:alert] = "Not allow!"
      redirect_to root_path
    end
  end

  def is_complete_trip?(trip_id)
    @trip_gostations = TripGostation.where(trip_id: trip_id, user_id: current_user.id)
    @trip_gostations.each do |tripGostation|
      if tripGostation.status == false
        return false
      end
    end

    return true
  end
end
