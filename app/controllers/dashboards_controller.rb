class DashboardsController < ApplicationController
  before_filter :require_login
  def show
    @ride_participants = current_user.ride_participants.current_rides.active_rides.not_cancelled_or_abandoned.role_wise
    @past_rides = current_user.ride_participants.past_rides.active_rides.confirmed_or_owner_participants.paginate(:page => params[:past_rides_page], :per_page => PAST_RIDES_PER_PAGE)
   
  end
end
