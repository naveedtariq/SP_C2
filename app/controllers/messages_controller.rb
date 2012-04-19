class MessagesController < ApplicationController
  before_filter :load_ride
  before_filter :require_login

  def new
    @message = Message.new
  end

  def create
    @message = current_user.messages.build(params[:message])
    @message.ride = @ride
    if @message.save
      cookies[:contact] = nil
      UserMailer.inbox_message_email(current_user, @ride.owner, @message).deliver
      flash[:notice] = "Message Sent"
      return redirect_to inbox_users_path(iframe: ride_message_path(@ride, req_id: params[:req_id])) if params[:contact_me]
      redirect_to ride_message_path(@ride, req_id: params[:req_id])
    else
      render :action => 'new'
    end
  end

  def show
    cookies[:contact] = nil
    req_users = []
    req_users << current_user.id
    if ((params[:req_id]).present?)
      @req_user = User.find(params[:req_id])
    else
      @req_user = @ride.owner
    end
    req_users << @req_user.id
    @messages = @ride.messages.where("user_id in (?) and owner_id in (?)", req_users, req_users).ordered
    render :layout => false
  end

  private
  def load_ride
    @ride = Ride.find(params[:ride_id])
  end
end
