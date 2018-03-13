class TripGostationsController < ApplicationController

  def check
    @trip_gostation = TripGostation.find(params[:id])
    @trip_gostation.update(status: "ture")
    redirect_to trip_path(@trip_gostation.trip_id)
  end
end
