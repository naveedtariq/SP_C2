class MessagesController < ApplicationController
  def new
    @message = Message.new
    @ride = Ride.find(params[:ride_id])
  end

  def create
    @message = current_user.messages.build(params[:message])
    @ride = Ride.find(params[:ride_id])
    @message.ride = @ride
    if @message.save
      cookies[:contact] = nil
      UserMailer.inbox_message_email(current_user,@ride.owner,@message).deliver
      flash[:notice] = "Message Sent"
      redirect_to ride_message_path @ride
    else
      render :action => 'new'
    end
  end

  def show
    cookies[:contact] = nil
    @ride = Ride.find(params[:ride_id])
    @req_user = User.find(params[:req_id]) if((params[:req_id]).present?)
    render :layout => false
  end
end
