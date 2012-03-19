class RidesController < ApplicationController
  before_filter :require_login, :only => [:create, :create_ride, :clone, :index, :update]
  before_filter :secure_ride_load, :only => [:edit, :update]
  def index
    @rides = current_user.created_rides.active
  end
  def new
    create_or_store_ride(Ride.new)
    @ride= Ride.new(retrieve_ride)
    render :action => "post_one"
  end
#  def edit
#    create_ride_cookie(@ride)
#    return render :json => retrieve_ride
#    @ride.attributes = retrieve_ride
#    render :action => "post_one"
#  end

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
    @ride.departure = params[:ride] && params[:ride]["departure"] || "all"
    @rides = Ride.search_rides(params[:ride]).paginate(:page => params[:page], :per_page => SEARCH_RIDES_PER_PAGE)
    @count = Ride.search_rides(params[:ride]).count
    return render(:action => "search_home") if params[:search_posted].blank?
  end

  def clone
    clone_ride = Ride.find(params[:id])
    @ride = Ride.new(clone_ride.attributes)
    return render :action => "new"
  end
  def update
    if @ride.valid?(params[:ride])
      @ride.modify!(params[:ride], current_user)
      return render :action => params[:next_step] unless params[:step] == "3"
      redirect_to(dashboard_path, :notice => 'Ride was successfully updated.')
    else
      render :action => "new"
    end
  end
  def updated
#    hash = retrieve_ride
#    @ride = Ride.find hash[:id]
#    @ride.attributes = hash
#    @ride.attributes = params[:ride]
#    store_ride(@ride)
#    return render :action => params[:next_step] unless params[:step] == "3"
#    return redirect_to update_ride_rides_path


       @ride.modify!(params[:ride], current_user)
       redirect_to(dashboard_path, :notice => 'Ride was successfully updated.')
  end
  def posted
    #return redirect_to new_ride_path if cookies[:ride].blank?
    @ride = Ride.new(retrieve_ride)
    @ride.attributes = params[:ride]
    store_ride(@ride)
    return render :action => params[:next_step] unless params[:step] == "3"
    return redirect_to create_ride_rides_path
  end
  def create_ride
    #return render :action => "404error_ride", :layout => false
    @ride = Ride.create!(retrieve_ride)
    clear_ride
    @ride.make_owner!(current_user)
    flash[:notice] = "Successfully created ride"
    redirect_to root_url
  end
  def posted_one
    #    return redirect_to new_ride_path if cookies[:ride].blank?
    @ride = Ride.new(retrieve_ride)
    return render :action => "post_two"
  end
  def post_two
    @ride = Ride.new(params[:ride])
  end

  
  private
  def secure_ride_load
    @ride = current_user.rides.find(params[:id])
  end
end
