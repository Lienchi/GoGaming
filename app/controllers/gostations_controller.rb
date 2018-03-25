class GostationsController < ApplicationController
  before_action :set_gostation, only: [:checkin, :uncheckin, :getCheckinStatus]

  def index
    @user = current_user
    @trip_gostations = TripGostation.where(user_id: current_user.id).uniq
    gon.gostations_belongs_to_trip = Gostation.where(id: @trip_gostations.map(&:gostation_id))
    gon.gostations_not_belongs_to_trip = Gostation.where.not(id: @trip_gostations.map(&:gostation_id))
    gon.trip_gostations = @trip_gostations
    gon.friendly_stores = Friendlystore.all
  end

  def checkin
    @gostation.checkins.create!(user: current_user)
    #@gostation.count_checkins
    #redirect_back(fallback_location: root_path)
  end

  def uncheckin
    checkins = Checkin.where(gostation: @gostation, user: current_user)
    checkins.destroy_all
    #@gostation.count_checkins
    #redirect_back(fallback_location: root_path)
  end

  def getCheckinStatus
    status = @gostation.is_checkedin?(current_user)
    render :json => { :status => status }
  end

  private

  def set_gostation
    @gostation = Gostation.find(params[:id])
  end
end
