class RidesController < ApplicationController
  before_filter :require_login, :only => [:create, :create_ride, :clone, :index, :update, :updated] # require the login to use that kind of functionality
  before_filter :secure_ride_load, :only => [:edit, :update]

  def index
    @rides = current_user.created_rides.active # rides of current user
  end

  def new
    create_or_store_ride(Ride.new) # create new ride instance
    @ride= Ride.new(retrieve_ride)
    render :layout=>false
  end

  def search # function for search ride
    @ride = Ride.new(params[:ride])
    @ride.departure = params[:ride] && params[:ride]["departure"] || "all" # by default all rides show against search rides
    @rides = Ride.search_rides(params[:ride]).paginate(:page => params[:page], :per_page => SEARCH_RIDES_PER_PAGE) # Specific number of rides show in one page after search
    @graph = Koala::Facebook::GraphAPI.new(current_user.oauth_code) if (current_user.present? && current_user.oauth_code.present?) # Graph API used her
    @count = Ride.search_rides(params[:ride]).count # count of rides search per page
    return render(:action => "search_home") if params[:search_posted].blank?
  end

  def clone # clone for post a ride
    clone_ride = Ride.find(params[:id])
    store_ride(clone_ride)
    @ride = Ride.new(retrieve_ride)
    render :action => "post_one"
  end

  def update # update ride here
    if @ride.valid?(params[:ride])
      @ride.modify!(params[:ride], current_user) # modify attributes
#      @ride.departure_time = @ride.departuredatetime
      unless params[:next_step] == "update"
        return render :action => params[:next_step]
      end
      UserMailer.ride_modify_email(current_user).deliver # Mail sent to the user when ride modify
      return redirect_to(dashboard_path, :notice => 'Ride was successfully updated.')
    else
      render :action => "new"
    end
  end

  def updated 
    @ride.modify!(params[:ride], current_user)
    redirect_to(dashboard_path, :notice => 'Ride was successfully updated.')
  end

  def posted
 if params[:step] == "2"
      params[:ride]["return_departuredatetime"] = "#{params[:ride][:return_trip_departure_date]} #{params[:ride]["return_departuredatetime(4i)"]}:#{params[:ride]["return_departuredatetime(5i)"]}"
      params[:ride].delete("return_departuredatetime(1i)")
      params[:ride].delete("return_departuredatetime(2i)")
      params[:ride].delete("return_departuredatetime(3i)")
      params[:ride].delete("return_departuredatetime(4i)")
      params[:ride].delete("return_departuredatetime(5i)")
    end
    @ride = Ride.new(retrieve_ride)
 @ride.return_departuredatetime = @ride.return_departuredatetime.to_time rescue @ride.return_departuredatetime = nil
 @ride.attributes = params[:ride]
    store_ride(@ride)
    #
    #    return render :json => cookies

    return render :action => params[:next_step] unless params[:step] == "3"
    return redirect_to create_ride_rides_path
  end

  def create_ride # Create new ride
    return render text: params.inspect
    @ride = Ride.create!(params[:ride])
    if(@ride.return_trip_checkbox.to_s == "1")
      @ride_return = Ride.new(retrieve_ride)
      @ride_return.to_location_id = @ride.from_location_id
      @ride_return.from_location_id = @ride.to_location_id
      @ride_return.departuredatetime = @ride.return_departuredatetime
      @ride_return.save!
      @ride_return.make_owner!(current_user)
    end
    clear_ride
    @ride.make_owner!(current_user) # make the owner of ride
    UserMailer.post_ride_email(current_user).deliver
    flash[:notice] = "Successfully created ride"
    redirect_to dashboard_path
  end

  def posted_one # Post Ride 1st step ride create
                 #    return redirect_to new_ride_path if cookies[:ride].blank?
    @ride = Ride.new(retrieve_ride)
        @ride.return_departuredatetime = @ride.return_departuredatetime.to_time rescue @ride.return_departuredatetime = nil
            return render :action => "post_two"
  end

  def post_two # Post ride 2nd step ride create
    @ride = Ride.new(params[:ride])
  end

  private
  def secure_ride_load # function for find rides of current user
    @ride = current_user.rides.find(params[:id])
  end


end
