class RidesController < ApplicationController
  before_filter :require_login, :only => [:create, :create_ride, :clone, :index, :update, :updated]             # require the login to use that kind of functionality
  before_filter :secure_ride_load, :only => [:edit, :update]

  def index
    @rides = current_user.created_rides.active                                  # rides of current user
  end
  def new
    create_or_store_ride(Ride.new)                                              # create new ride instance
    @ride= Ride.new(retrieve_ride)
    render :action => "post_one"
  end
  #  def edit
  #    create_ride_cookie(@ride)
  #    return render :json => retrieve_ride
  #    @ride.attributes = retrieve_ride
  #    render :action => "post_one"
  #  end

  #def create
  #  @ride = Ride.new(params[:ride])
  #  if @ride.save
  #    @ride.make_owner!(current_user)
  #    flash[:notice] = "Successfully created ride"
  #    redirect_to root_url
  #  else
  #    render :action => 'new'
  #  end
  #end

  def search                                                                    # function for search ride
    @ride = Ride.new(params[:ride])
    @ride.departure = params[:ride] && params[:ride]["departure"] || "all"      # by default all rides show against search rides
    @rides = Ride.search_rides(params[:ride]).paginate(:page => params[:page], :per_page => SEARCH_RIDES_PER_PAGE)                 # Specific number of rides show in one page after search
    @graph = Koala::Facebook::GraphAPI.new(current_user.oauth_code)  if(current_user.present? && current_user.oauth_code.present?)    # Graph API used her
    @count = Ride.search_rides(params[:ride]).count                             # count of rides search per page
    return render(:action => "search_home") if params[:search_posted].blank?
  end

  def clone                                                                     # clone for post a ride
    clone_ride = Ride.find(params[:id])
    store_ride(clone_ride)
    @ride = Ride.new(retrieve_ride)
    render :action => "post_one"
  end
  def update                                                                    # update ride here
    if @ride.valid?(params[:ride])
      @ride.modify!(params[:ride], current_user)                                # modify attributes
      unless params[:next_step] == "update"
        return render :action => params[:next_step]
      end
      UserMailer.ride_modify_email(current_user).deliver                      # Mail sent to the user when ride modify
      return redirect_to(dashboard_path, :notice => 'Ride was successfully updated.')
    else
      render :action => "new"
    end
  end
  def updated                                                                   # function for update ride
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
    if params[:step] == "2"
      params[:ride]["return_trip_departure_time"] = "#{params[:ride][:return_trip_departure_date]} #{params[:ride]["return_trip_departure_time(4i)"]}:#{params[:ride]["return_trip_departure_time(5i)"]}"
      params[:ride].delete("return_trip_departure_time(1i)")
      params[:ride].delete("return_trip_departure_time(2i)")
      params[:ride].delete("return_trip_departure_time(3i)")
      params[:ride].delete("return_trip_departure_time(4i)")
      params[:ride].delete("return_trip_departure_time(5i)")
    end

    #return redirect_to new_ride_path if cookies[:ride].blank?
#      return render :json => params[:ride]
  @ride = Ride.new(retrieve_ride)
    @ride.attributes = params[:ride]
    store_ride(@ride)
#    
#    return render :json => cookies

    return render :action => params[:next_step] unless params[:step] == "3"
    return redirect_to create_ride_rides_path
  end
  def create_ride                                                               # Create new ride
#    return render :json => @ride
    @ride = Ride.create!(retrieve_ride)
    clear_ride
    @ride.make_owner!(current_user)                                             # make the owner of ride
    UserMailer.post_ride_email(current_user).deliver
    flash[:notice] = "Successfully created ride"
    redirect_to dashboard_path
  end
  def posted_one                                                                # Post Ride 1st step ride create
    #    return redirect_to new_ride_path if cookies[:ride].blank?
    @ride = Ride.new(retrieve_ride)
    return render :action => "post_two"
  end
  def post_two                                                                  # Post ride 2nd step ride create
    @ride = Ride.new(params[:ride])
  end

  private
  def secure_ride_load                                                          # function for find rides of current user
    @ride = current_user.rides.find(params[:id])
  end


end
