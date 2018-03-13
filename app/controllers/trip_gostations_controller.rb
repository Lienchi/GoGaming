class TripGostationsController < ApplicationController
  def check
 
    @trip_gostation = TripGostation.find(params[:id])
    @trip_gostation.update(status: !(@trip_gostation.status))

  end
end
