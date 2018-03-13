class ChallengesController < ApplicationController
  def create
    @challenge = Challenge.create(challenge_params)
  end
  

  private 

  def challenge_params
    params.require(:challenge).permit(:user_id, :trip_id)
  end
end
