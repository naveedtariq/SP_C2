class FeedbacksController < ApplicationController

  def new
    @feedback = Feedback.new
  end

  def create
   @feedback = current_user.feedbacks.build(params[:feedback])
    if @feedback.save

      flash[:notice] = "feedback Sent"
      redirect_to new_feedback_path
    else
      render :action => 'new'
    end
  end
end

