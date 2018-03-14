class Admin::TripsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  
  def index
    @trips = Trip.all

    if params[:id]
      @trip = Trip.find(params[:id])
    else
      @trip = Trip.new
    end
  end
end
