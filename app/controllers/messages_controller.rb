class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
  @message = current_user.messages.build(params[:message])
  @ride = Ride.find(params[:ride_id])
  @message.ride = @ride
  @message.owner = @ride.owner
  #@message = Message.new(params[:message])
   if @message.save
    flash[:notice] = "Message Sent"
    redirect_to dashboard_path
   else
      render :action => 'new'
    end
  end

   def show
    @message = Message.find(params[:id])
  end
end
