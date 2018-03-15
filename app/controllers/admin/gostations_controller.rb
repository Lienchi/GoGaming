class Admin::GostationsController < ApplicationController

  before_action :set_gostation, only:[:edit, :update, :destroy]

 def index
    @gostations = Gostation.all
    if params[:id]
      @gostation = Gostation.find(params[:id])
    else
      @gostation = Gostation.new
    end
    @Taipei = Gostation.where(City: "台北市")
  end

  def create
    @gostation = Gostation.new(gostation_param)
    if @gostation.save
      flash[:notce] = "已儲存"
      redirect_to admin_gostations_path
    else
      flash.now[:alert] = "儲存失敗"
      render :new
    end
  end

  def update
     @gostation.update(gostation_param)
     redirect_to admin_gostations_path
  end

  def destroy
     @gostation.delete
     redirect_to admin_gostations_path
  end


  private

  def gostation_param
    params.require(:gostation).permit(:LocName, :Latitude, :Longitude, :ZipCode, :Address, :District, :City, :AvailableTime)
  end

  def set_gostation
    @gostation = Gostation.find(params[:id])
  end
end
