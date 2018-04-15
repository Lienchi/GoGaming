class ChallengesController < ApplicationController
  def create
    @challenge = Challenge.create(challenge_params)
  end
  
  def setDisplayModalStatus
    challenge = Challenge.find(params[:id])
    challenge.update(displaymodal: false)
  end

  private 

  def challenge_params
    params.require(:challenge).permit(:user_id, :trip_id, :completetime)
  end
end
