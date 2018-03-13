class TripsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @trips = Trip.all
 
  end

  def show
    @trip = Trip.find(params[:id])
    @trip_gostations = TripGostation.where(trip_id: @trip)
    @challenge = Challenge.new
  end

end
