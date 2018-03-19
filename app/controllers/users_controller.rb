class UsersController < ApplicationController
  def index

    @users = User.all 
  end
  def show
    @user = current_user
  end

  def leaderboards
    @scores = Merit::Score.top_scored
    @friendscores = Merit::Score.top_scored
  end
end
