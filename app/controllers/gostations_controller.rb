class GostationsController < ApplicationController
  before_action :set_gostation, only: [:checkin, :uncheckin, :getCheckinStatus]

  @@checkin_pts = 3
  @@checkin_pts_offpeak = 5
  @@offpeak_start = "22:00:00"
  @@offpeak_end = "23:59:59"
  def index
    @user = current_user
    @trip_gostations = TripGostation.where(user_id: current_user.id).uniq
    gon.gostations = Gostation.all
    gon.friendly_stores = Friendlystore.all

    gon.offpeak_start = @@offpeak_start
    gon.offpeak_end = @@offpeak_end
    gon.checkin_pts = @@checkin_pts
    gon.checkin_pts_offpeak = @@checkin_pts_offpeak
  end

  def checkin
    @checkin = @gostation.checkins.create!(user: current_user)

    if checkin_time(@checkin, @@offpeak_start, @@offpeak_end)
      current_user.add_points(@@checkin_pts_offpeak, category: 'gostation')
      current_user.experience += @@checkin_pts_offpeak
      current_user.save
    else
      current_user.add_points(@@checkin_pts, category: 'gostation')
      current_user.experience += @@checkin_pts
      current_user.save
    end

    # if checkin_time(@checkin, "14:00:00", "16:00:00")
    #   current_user.add_points(10, category: 'gostation')
    # end
  end

  def uncheckin
    checkins = Checkin.where(gostation: @gostation, user: current_user)
    checkins.destroy_all
    current_user.subtract_points(@@checkin_pts, category: 'gostation')
    current_user.experience -= @@checkin_pts
    current_user.save
  end

  def getCheckinStatus
    status = @gostation.is_checkedin?(current_user)
    render :json => { :status => status }
  end

  def getCurrentUserPoints
    render :json => { :points => current_user.points }
  end

  def getCurrentUserExp
    render :json => { :experience => current_user.experience }
  end

  # check if the ckeckin_in time in certain time zone
  def checkin_time(checkin, start_time, end_time)
    # ex: checkin_time(@checkin, "22:00:00", "23:59:59")
    #+8*60*60 for time.zone='taipei'
    #time = (checkin.created_at+8*60*60).strftime('%H:%M:%S')
    time = (checkin.created_at+8*60*60).strftime('%T')
    return time > start_time && time < end_time
  end

  private

  def set_gostation
    @gostation = Gostation.find(params[:id])
  end

end
