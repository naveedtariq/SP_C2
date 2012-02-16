class RidesController < ApplicationController
before_filter :require_login


 def new
  @ride = ride.new
end

def create
  @ride = ride.new(params[:ride])
  if @ride.save
    flash[:notice] = "Successfully created ride."
    redirect_to rides_path
  else
    render :action => 'new'
  end
end
end
