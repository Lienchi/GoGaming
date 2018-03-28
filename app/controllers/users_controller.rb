class UsersController < ApplicationController
  def index
    @users = User.all 
  end
  def show
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to user_path

  end

  def leaderboards
    @scores = Merit::Score.top_scored
    @friends = current_user.followings

  end


  private

  def user_params
    params.require(:user).permit(:name, :avatar)
  end
end
