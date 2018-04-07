class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])

    top_scored = Merit::Score.top_scored(limit: User.count)
    user = top_scored.detect{|h| h['user_id'] == @user.id }
    @user_rank = top_scored.index(user)+1
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to user_path

  end

  def leaderboards
    @scores = Merit::Score.top_scored
  end

  def f_leaderboards
    @friends_scores = friends_leaderboards(current_user).sort_by { |k, v| k[:sum_points]}.reverse
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
