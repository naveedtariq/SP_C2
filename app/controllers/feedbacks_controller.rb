class FeedbacksController < ApplicationController
   layout false
   before_filter :load_ride                                                      # Require load_ride for messages
   before_filter :require_login                                                  # Require Login for messages

   def new                                                                       # function to make new object of feedback
    @left_count = 0                                                             # variable to count feedbacks which are left to be give
    @feedback = Feedback.new
    return render :partial => "new", :layout => false
  end

  def create                                                                    # function for given feedback
#    return render :text => params[:feedback].inspect
    @feedback = current_user.feedbacks.build(params[:feedback])                 # Create the feedback by current user
    if @feedback.save                                                           # if feedback save then redirect to feedback page
      UserMailer.feedback_email(current_user,@ride,@feedback).deliver
      flash[:notice] = "feedback Sent"
      redirect_to feedback_users_path
    else
      render :action => 'new'
    end
  end

   private
   def load_ride
     @ride = Ride.find(params[:ride_id])                                         # find ride against ride_id
   end
end

