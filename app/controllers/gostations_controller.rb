class GostationsController < ApplicationController
  def index
    @user = current_user
    gon.gostations = Gostation.all
  end
end
