class TripsController < ApplicationController
  
  def index
    @trips = Trip.all
    @followings = current_user.followings
  end

  def show
    @trip = Trip.find(params[:id])
    @trip_gostations = TripGostation.where(trip_id: @trip.id, user_id: current_user.id)
    gon.gostations = Gostation.where(id: @trip_gostations.map(&:gostation_id))
  end
  

end
