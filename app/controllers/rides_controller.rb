class RidesController < ApplicationController
  before_filter :require_login
  before_filter :secure_ride_load, :only => [:edit, :update]
  def index
    @rides = current_user.created_rides.active
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
    @rides = Ride.search_rides(params[:ride]).paginate(:page => params[:page], :per_page => SEARCH_RIDES_PER_PAGE)
  end

  def clone
    clone_ride = Ride.find(params[:id])
    @ride = Ride.new(clone_ride.attributes)
    return render :action => "new"
  end
  def update
    if @ride.valid?(params[:ride])
      @ride.modify!(params[:ride], current_user)
      redirect_to(dashboard_path, :notice => 'Ride was successfully updated.')
    else
      render :action => "new"
    end
  end

    def searchclone
    @ride = Ride.new(params[:ride])
    end
  private
  def secure_ride_load
    @ride = current_user.rides.find(params[:id])
  end
end
