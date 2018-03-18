class GostationsController < ApplicationController
  def index
    @user = current_user
    @trip_gostations = TripGostation.where(user_id: current_user.id).uniq
    gon.gostations_belongs_to_trip = Gostation.where(id: @trip_gostations.map(&:gostation_id))
    gon.gostations_not_belongs_to_trip = Gostation.where.not(id: @trip_gostations.map(&:gostation_id))
  end
end
