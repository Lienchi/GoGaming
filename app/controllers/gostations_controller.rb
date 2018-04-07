class GostationsController < ApplicationController
  before_action :set_gostation, only: [:checkin, :uncheckin, :getCheckinStatus]

  def index
    @user = current_user
    @trip_gostations = TripGostation.where(user_id: current_user.id).uniq
    gon.gostations = Gostation.all
    gon.friendly_stores = Friendlystore.all
  end

  def checkin
    @checkin = @gostation.checkins.create!(user: current_user)
    current_user.add_points(3, category: 'gostation')
    #@gostation.count_checkins
    #redirect_back(fallback_location: root_path)

    if checkin_time(@checkin, "22:00:00", "23:59:59")
      current_user.add_points(5, category: 'gostation')
    end

    # if checkin_time(@checkin, "14:00:00", "16:00:00")
    #   current_user.add_points(10, category: 'gostation')
    # end
  end

  def uncheckin
    checkins = Checkin.where(gostation: @gostation, user: current_user)
    checkins.destroy_all
    current_user.subtract_points(3, category: 'gostation')
    #@gostation.count_checkins
    #redirect_back(fallback_location: root_path)
  end

  def getCheckinStatus
    status = @gostation.is_checkedin?(current_user)
    render :json => { :status => status }
  end

  def getCurrentUserPoints
    render :json => { :points => current_user.points }
  end

  # check if the ckeckin_in time in certain time zone
  def checkin_time(checkin, start_time, end_time)
    # ex: checkin_time(@checkin, "22:00:00", "23:59:59")
    time = (checkin.created_at+8*60*60).strftime('%H:%M:%S')
    if time > start_time && time < end_time
      return true
    else
      return false
    end
  end

  private

  def set_gostation
    @gostation = Gostation.find(params[:id])
  end

end
