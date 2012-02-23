class RidesController < ApplicationController
  before_filter :require_login
  def index
    @rides = current_user.created_rides
  end
  def new
    @ride= Ride.new
  end

  def create
    @ride = current_user.created_rides.build(params[:ride])
    if @ride.save
      flash[:notice] = "Successfully created ride"
      redirect_to root_url
    else
      render :action => 'new'
    end
  end

  def search
    @ride = Ride.new(params[:ride])
    @rides = Ride.search_rides(params[:ride])
  end

  def show
    @ride = Ride.find(params[:id])
  end
end
