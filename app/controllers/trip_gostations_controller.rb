class TripGostationsController < ApplicationController

  def check
    @trip_gostation = TripGostation.find(params[:id])
    @trip_gostation.update(status: !(@trip_gostation.status))
    @trip_gostations = TripGostation.where(trip_id: @trip_gostation.trip_id)
    @challeng.user_id = current_user.id
    @challenge.trip_id = @trip_gostation.trip_id
    for i in 0...@trip_gostations.length
      count = 0
      if i.status == true
        count +=1
      end
      if count == 5
        @challenge.status = true
      end
    end

  end

end
