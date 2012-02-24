class RideParticipantsController < ApplicationController
  before_filter :load_ride
  def new
    @ride_participant = @ride.ride_participants.build
  end
  
  def create
    @ride_participant = @ride.ride_participants.build(params[:ride_participant])
    @ride_participant.role = ROLES_FOR_RIDES[:pending]
    @ride_participant.user_id = current_user
    if @ride_participant.save
      flash[:notice] = "Successfully Booked "
      redirect_to dashboard_path
    else
      render :action => 'new'
    end
  end
  private
  def load_ride
    @ride = Ride.find(params[:ride_id])
  end
end
