class RideParticipantsController < ApplicationController

  before_filter :require_login, :only => [:create_participant, :accept, :deny, :cancel]                   # require the login to use that kind of functionality
  before_filter :load_ride, :only => [:new, :create, :cancel, :create_participant, :contact, :update]     # require load_ride before this controller use
  before_filter :secure_load_ride, :only => [:accept, :deny]                                              # require secure_load_ride for this

  def new
    @graph = Koala::Facebook::GraphAPI.new(current_user.oauth_code) if (current_user.present? && current_user.oauth_code.present?)                # use Graph API  of facebook
    @ride_participant = @ride.ride_participants.build                           # ride_participant with respect to ride
    @message = Message.new                                                      # new object of message
  end

  def create_participant                                                        # function for create participant
    @ride_participant = @ride.ride_participants.build(retrieve_participant)     # ride_participant created with respect to ride
    @ride_participant.role = ROLES_FOR_RIDES[:pending]                          # firstly ride_participant role will be pending
    @ride_participant.user_id = current_user.id                                 # Ride_participant will be current user which became participant of ride
    if @ride_participant.save
      UserMailer.ride_join_email(current_user, @ride_participant.owner).deliver # when current user join ride mail send to the ride_owner that current user want to join your ride
      clear_participant
      flash[:notice] = "Successfully Booked "
      redirect_to dashboard_path
    else
      render :action => 'new'
    end
  end

#  def create_message
#       @message = current_user.messages.build(params[:message])
##   @message = Message.new(params[:message])
#   if @message.save
#    flash[:notice] = "Message Sent"
#    redirect_to new_ride_ride_participant_path
#   else
#      render :action => 'new'
#    end
#  end
  def create
    @ride_participant = @ride.ride_participants.build(params[:ride_participant])
    store_ride_participants(@ride_participant)                                  # Store ride_participant
    return redirect_to create_participant_ride_ride_participants_path(@ride)

  end

  def accept                                                                    # Accept function for ride_participant which want to join ride
    @ride_participant = @ride.ride_participants.find(params[:id])
    @ride_participant.update_attribute(:role, ROLES_FOR_RIDES[:confirmed])
    return redirect_to dashboard_path
  end

  def deny                                                                      # Deny function for ride_participant that owner not allowed you to join ride
    @ride_participant = @ride.ride_participants.find(params[:id])
    @ride_participant.update_attribute(:role, ROLES_FOR_RIDES[:rejected])
    UserMailer.ride_deny_email(@ride_participant,current_user).deliver
    return redirect_to dashboard_path
  end

  def contact_info                                                              # only for redirection
    return redirect_to dashboard_path
  end

  def cancel                                                                    # cancel function for cancel the specific ride
    @ride_participant = @ride.ride_participants.where({:id => params[:id], :user_id => current_user.id}).first
    @ride_participant.cancel!
    @ride.cancel! if @ride.ride_participants.active_participants.blank?
    UserMailer.ride_cancel_email(current_user).deliver                          # Mail send to user that you have cancel that specific ride
    return redirect_to dashboard_path
  end

  def contact
    @ride_participant = RideParticipant.find params[:id]                        # find specific ride_participant with respect to id
  end

  def update                                                                    # Function for update ride_participant
    @ride_participant = RideParticipant.find(params[:id])
    @ride_participant.update_attributes! params[:ride_participant]              # Modify here
    UserMailer.ride_accepted_email(current_user,RideParticipant.find(params[:accept]),@ride_participant).deliver
    return redirect_to accept_ride_ride_participant_path(@ride, RideParticipant.find(params[:accept]))
  end

  private
  def load_ride                                                                 # function for load ride
    @ride = Ride.find(params[:ride_id])
  end

  def secure_load_ride                                                          # function for find rides of current user
    @ride = current_user.rides.find(params[:ride_id])
  end
end
