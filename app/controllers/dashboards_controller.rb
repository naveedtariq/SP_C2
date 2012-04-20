class DashboardsController < ApplicationController
  before_filter :require_login                                                  # Require Login to see the dashboard
  def show                                  # function to show the current and past rides of current user
    @ride_participants = current_user.ride_participants.current_rides.active_rides.not_cancelled_or_abandoned.role_wise             # Retrieve the current user rides which are active 
    @past_rides = current_user.ride_participants.past_rides.active_rides.confirmed_or_owner_participants.paginate(:page => params[:past_rides_page], :per_page => PAST_RIDES_PER_PAGE)    # Retrieve the current user past rides those rides which are confirmed or current user is owner of ride
   
  end
end
