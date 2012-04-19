class FeedbacksController < ApplicationController

  def new                                                                       # function to make new object of feedback
    @left_count = 0                                                             # variable to count feedbacks which are left to be give
    @feedback = Feedback.new
  end

  def create                                                                    # function for given feedback
    @feedback = current_user.feedbacks.build(params[:feedback])                 # Create the feedback by current user
    if @feedback.save                                                           # if feedback save then redirect to feedback page
      flash[:notice] = "feedback Sent"
      redirect_to new_feedback_path
    else
      render :action => 'new'
    end
  end
end

