class RidesController < ApplicationController
  before_filter :require_login
  def index
    @rides = current_user.created_rides
  end
  def new
    @ride= Ride.new
  end

  def create
    @ride = Ride.new(params[:ride])
    if @ride.save
      @ride.make_owner!(current_user)
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

  def clone
    clone_ride = Ride.find(params[:id])
    @ride = Ride.new(clone_ride.attributes)
    return render :action => "new"
  end

  def edit
    @ride = Ride.find(params[:id])
  end
  def update
    @ride = Ride.find(params[:id])
    if @ride.update_attributes(params[:ride])
      redirect_to(dashboard_path, :notice => 'Ride was successfully updated.')
    else
      render :action => "new"
    end
  end

  def destroy
    @destroy_ride=Ride.find(params[:id])
    @destroy_ride.destroy
    redirect_to(dashboard_path, :notice => 'Ride was successfully destroy.')
  end
end
