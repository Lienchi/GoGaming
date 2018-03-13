class TripsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @trips = Trip.all
 
  end

  def show
    @trip = Trip.find(params[:id])
    @trip_gostations = TripGostation.where(trip_id: @trip.id, user_id: current_user.id)
  end
  
  def challenge
     @trip = Trip.find(params[:id])
     @trip.challenges.create!(user: current_user)
     redirect_to trip_path(@trip)
  end
end
