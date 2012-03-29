class RideParticipantsController < ApplicationController

  before_filter :require_login, :only => [:create_participant, :accept, :deny, :cancel]
  before_filter :load_ride, :only => [:new, :create, :cancel, :create_participant]
  before_filter :secure_load_ride, :only => [:accept, :deny]
  def new
    @graph = Koala::Facebook::GraphAPI.new(current_user.oauth_code) if(current_user.present? && current_user.oauth_code.present?)
    @ride_participant = @ride.ride_participants.build
    @message = Message.new
  end
  def create_participant
    @ride_participant = @ride.ride_participants.build(retrieve_participant)
    @ride_participant.role = ROLES_FOR_RIDES[:pending]
    @ride_participant.user_id = current_user.id
    if @ride_participant.save
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
    store_ride_participants(@ride_participant)
    return redirect_to create_participant_ride_ride_participants_path(@ride)
    
  end
  def accept
    @ride_participant = @ride.ride_participants.find(params[:id])
    @ride_participant.update_attribute(:role, ROLES_FOR_RIDES[:confirmed])
    return redirect_to dashboard_path
  end
  def deny
    @ride_participant = @ride.ride_participants.find(params[:id])
    @ride_participant.update_attribute(:role, ROLES_FOR_RIDES[:rejected])
    return redirect_to dashboard_path
  end
  def cancel
    @ride_participant = @ride.ride_participants.where({:id => params[:id], :user_id => current_user.id}).first
    @ride_participant.cancel!
    @ride.cancel! if @ride.ride_participants.active_participants.blank?
    return redirect_to dashboard_path
  end
  
  private
  def load_ride
    @ride = Ride.find(params[:ride_id])
  end
  def secure_load_ride
    @ride = current_user.rides.find(params[:ride_id])
  end
end
