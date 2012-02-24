class DashboardsController < ApplicationController

  def show
    @ride_participants = current_user.ride_participants.current_rides.role_wise
    @past_rides = current_user.ride_participants.past_rides
  end
end
