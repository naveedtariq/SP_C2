class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = current_user.messages.build(params[:message])
    @ride = Ride.find(params[:ride_id])
    @message.ride = @ride
    if @message.save
      flash[:notice] = "Message Sent"
      redirect_to ride_message_path @ride
    else
      render :action => 'new'
    end
  end

  def show
    @ride = Ride.find(params[:ride_id])
  end
end
