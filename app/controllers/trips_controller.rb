class TripsController < ApplicationController
  
  def index
    @trips = Trip.all
    @followings = current_user.followings
    @trips_count = Trip.all.count
    @challenge_trips = Challenge.where(user_id: current_user).count
    @unchallenge_trips = @trips_count - @challenge_trips
    gon.sign_in_count = current_user.sign_in_count
  end

  def show
    @trip = Trip.find(params[:id])
    @trip_gostations = TripGostation.where(trip_id: @trip.id, user_id: current_user.id)
    gon.gostations = Gostation.where(id: @trip_gostations.map(&:gostation_id))
    gon.trip_gostations = @trip_gostations
    gon.friendly_stores = Friendlystore.all
    gon.gostation_sites = Site.where(trip_id: @trip.id)
    gon.is_complete_trip = is_complete_trip?(@trip.id)

    @comment = Comment.new
    @comments = Comment.where(trip_id: @trip).order(created_at: :desc)
    @challenge = Challenge.where(trip_id: @trip).order(:completetime).first
    gon.sign_in_count = current_user.sign_in_count
  end
  



end
