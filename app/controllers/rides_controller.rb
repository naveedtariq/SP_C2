class RidesController < ApplicationController
  def new
    @ride= Ride.new
    @ride.location = Location.new
  end

  def create
    @ride = Ride.new(params[:ride])
    if @ride.save
      flash[:notice] = "Successfully created ride."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
end
