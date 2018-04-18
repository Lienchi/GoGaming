class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @user.level = @user.getUserLevel()

    top_scored = Merit::Score.top_scored(limit: User.count)
    user = top_scored.detect{|h| h['user_id'] == @user.id }
    @user_rank = User.count
    if user
      @user_rank = top_scored.find_index(user)+1
    end
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to user_path

  end

  def leaderboards
    scores = Merit::Score.top_scored(limit: User.count)
    ids = scores.map{|score| score["user_id"]}
    @leaderusers = User.find(ids)
    @leaderusers.each do |u|
      u.level = u.getUserLevel()
    end
  end

  def f_leaderboards
    friends_scores = friends_leaderboards(current_user).sort_by { |k, v| k[:sum_points]}.reverse
    ids = friends_scores.map{|score| score[:user_id]}
    @leaderusers = User.find(ids).sort_by{|m| ids.index(m.id)}
    @leaderusers.each do |u|
      u.level = u.getUserLevel()
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :avatar)
  end

  def friends_leaderboards(user)
    leaderboard = []
    user.followings.each do |friend| 
      leaderboard << {:user_id => friend.id, :sum_points => friend.points }
    end
    leaderboard << {:user_id => user.id, :sum_points => user.points }
    return leaderboard
  end

end
