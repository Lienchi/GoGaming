class TripGostationsController < ApplicationController

  def check
    @trip_gostation = TripGostation.find(params[:id])
    #toggle status for testing
    if @trip_gostation.status == false
      @trip_gostation.update(status: "ture")
    else
      @trip_gostation.update(status: "false")
    end

    if is_complete_trip(@trip_gostation.trip_id)
      Challenge.create!(user: current_user, trip_id: @trip_gostation.trip_id)
      current_user.add_points(33, category: 'trip')
      redirect_to trips_path
       #需要改成發post 給challenge_trip_path
    else
      redirect_to trip_path(@trip_gostation.trip_id)
    end
  end

  def is_complete_trip(trip_id)
    @trip_gostations = TripGostation.where(trip_id: trip_id, user_id: current_user.id)
    @trip_gostations.each do |tripGostation|
      if tripGostation.status == false
        return false
      end
    end

    return true
  end
end
