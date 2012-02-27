class RideParticipantsController < ApplicationController
  before_filter :load_ride, :only => [:new, :create, :cancel]
  before_filter :secure_load_ride, :only => [:accept, :deny]
  def new
    @ride_participant = @ride.ride_participants.build
  end
  
  def create
    @ride_participant = @ride.ride_participants.build(params[:ride_participant])
    @ride_participant.role = ROLES_FOR_RIDES[:pending]
    @ride_participant.user_id = current_user.id
    if @ride_participant.save
      flash[:notice] = "Successfully Booked "
      redirect_to dashboard_path
    else
      render :action => 'new'
    end
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
