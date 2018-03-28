class CommentsController < ApplicationController


  def create
    @trip = Trip.find(params[:trip_id])
    @comment = @trip.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to trip_path(@trip)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :trip_id, :user_id)
  end
end
