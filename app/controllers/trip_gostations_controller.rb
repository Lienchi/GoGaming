class TripGostationsController < ApplicationController
  before_action :set_trip_gostation, only: [:check, :getCheckinStatus]

  def check
    #toggle status for testing
    if @trip_gostation.status == false
      @trip_gostation.update(status: "ture")
    else
      @trip_gostation.update(status: "false")
    end

    if is_complete_trip?(@trip_gostation.trip_id)
      @first = Trip.find(@trip_gostation.trip_id).trip_gostations.where(user_id:current_user.id).order(:updated_at).first.updated_at
      @last = Trip.find(@trip_gostation.trip_id).trip_gostations.where(user_id:current_user.id).order(updated_at: :desc).first.updated_at
      @completetime = ((@last-@first)/60).round(2)
      Challenge.create!(user: current_user, trip_id: @trip_gostation.trip_id, completetime: @completetime )
      # current_user.add_points(33, category: 'trip')
      redirect_to trip_path(@trip_gostation.trip_id)
    else
      #redirect_to trip_path(@trip_gostation.trip_id)
    end
  end

  def getCheckinStatus
    status = @trip_gostation.status
    render :json => { :status => status }
  end

  

  private

  def set_trip_gostation
    @trip_gostation = TripGostation.find(params[:id])
  end
end
