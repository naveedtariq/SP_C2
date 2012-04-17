class RidesController < ApplicationController
  before_filter :require_login, :only => [:create, :create_ride, :clone, :index, :update, :updated]
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
    @graph = Koala::Facebook::GraphAPI.new(current_user.oauth_code)  if(current_user.present? && current_user.oauth_code.present?)
    @count = Ride.search_rides(params[:ride]).count
    return render(:action => "search_home") if params[:search_posted].blank?
  end

  def clone
    clone_ride = Ride.find(params[:id])
    store_ride(clone_ride)
    @ride = Ride.new(retrieve_ride)
    render :action => "post_one"
  end
  def update
    if @ride.valid?(params[:ride])
      @ride.modify!(params[:ride], current_user)
      unless params[:next_step] == "update"
        return render :action => params[:next_step]
      end
        UserMailer.ride_modify_email(current_user).deliver
        return redirect_to(dashboard_path, :notice => 'Ride was successfully updated.')
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
     params[:ride]["departure_time(1i)"], params[:ride]["departure_time(2i)"], params[:ride]["departure_time(3i)"] = params[:ride]["departure_date"].split("-")     if params[:step] == "2"
    #return redirect_to new_ride_path if cookies[:ride].blank?
    @ride = Ride.new(retrieve_ride)
    @ride.attributes = params[:ride]
    store_ride(@ride)
    return render :action => params[:next_step] unless params[:step] == "3"
    return redirect_to create_ride_rides_path
  end
  def create_ride
    @ride = Ride.create!(retrieve_ride)
    clear_ride
    @ride.make_owner!(current_user)
    flash[:notice] = "Successfully created ride"
    redirect_to dashboard_path
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
