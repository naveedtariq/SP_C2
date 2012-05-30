class MessagesController < ApplicationController
  before_filter :load_ride                                                      # Require load_ride for messages
  before_filter :require_login                                                  # Require Login for messages

  def new                                                                       # function for create new object of message
    @message = Message.new
  end

  def create
    @message = current_user.messages.build(params[:message])                    # Current user create the message
    @message.ride = @ride                                                       # against which ride message create
    if @message.save
      cookies[:contact] = nil                                                   # assign contact cookies nil
      UserMailer.inbox_message_email(current_user, @ride.owner, @message).deliver   # Mail sent to the owner of ride for message created by current user
      flash[:notice] = "Message Sent"
     #return redirect_to inbox_users_path(iframe: ride_message_path(@ride, req_id: params[:req_id])) if params[:contact_me]
      #redirect_to ride_message_path(@ride, req_id: params[:req_id])
      redirect_to :back
    else
      render :action => 'new'
    end
  end

  def show                                                                      # function for show message b/w sender and receiver
    cookies[:contact] = nil                                                     # assign contact cookies nil
    req_users = []
    req_users << current_user.id
    if ((params[:req_id]).present?)
      @req_user = User.find(params[:req_id])
    else
      @req_user = @ride.owner
    end
    req_users << @req_user.id
    @conversation = @ride.messages.where("user_id in (?) and owner_id in (?)", req_users, req_users).ordered  # show the message b/w sender and receiver
    @user = current_user
    @messages = current_user.owned_messages.rev_ordered
  end

  private
  def load_ride
    @ride = Ride.find(params[:ride_id])                                         # find ride against ride_id
  end
end
