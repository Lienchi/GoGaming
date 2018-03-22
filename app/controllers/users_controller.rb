class UsersController < ApplicationController
  def index

    @users = User.all 
  end
  def show
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to user_path

  end

  def leaderboards
    @scores = Merit::Score.top_scored
    @friendscores = Merit::Score.top_scored
  end


  private

  def user_params
    params.require(:user).permit(:avatar)
  end
end
