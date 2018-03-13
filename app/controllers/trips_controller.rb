class TripsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @trips = Trip.all
 
  end

  def show
    @trip = Trip.find(params[:id])
    @trip_gostations = TripGostation.where(trip_id: @trip)
  end
  
  def challenge
     @trip = Trip.find(params[:id])
     @trip.challenges.create!(user_id: current_user.id)
     redirect_to trip_path(@trip)
  end
end
