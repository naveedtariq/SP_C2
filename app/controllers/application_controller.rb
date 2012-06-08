class ApplicationController < ActionController::Base

  before_filter :authenticate
  protect_from_forgery
  before_filter :save_request # Require save_request filter
  helper_method :production?

  def save_request
    #    RequestLogger.create!(:request_url => request.url, :user_agent => request.user_agent, :ip_address => request.remote_ip, :referer => request.referer, :cookie_string => request.cookies)            // save the all cookies with ip_address
  end

  def not_authenticated # if not authenticate user the redirect to login page
    redirect_to login_url
  end

  def production?
    Rails.env == "production" # define the rails development
  end

  def to_hash(str)
    Hash[str.gsub(/{|}|\"/, "").split(",").map { |m| m.strip.split("=>") }] # Apply hash function
  end

  def create_or_store_ride(ride)
    cookies[:ride] ||= ride.attributes.to_s.gsub!("nil", "") # Create and store the post ride information in cookies
  end

  def create_ride_cookie(ride) # cookies for post ride information save in cookies
    cookies[:ride] = ride.attributes.to_s.gsub!("nil", "")
  end

  def store_ride(ride) # To store the ride information
    ride_return_departuredatetime = ride.return_departuredatetime.to_s
    ride_departuredatetime = ride.departuredatetime.to_s
    ride_return_trip_checkbox = ride.return_trip_checkbox.to_s
    ride_attributes = ride.attributes
    ride_attributes.delete("departure_date")
    ride_attributes.delete("new_departure_time")
    ride_attributes.delete("ampm_time")
    ride_attributes.delete("return_trip_checkbox")
    ride_attributes.delete("return_trip_departure_date")
    ride_attributes.delete("return_new_departure_time")
    ride_attributes.delete("return_new_ampm_time")
    ride_attributes.delete("return_departuredatetime")
    ride_attributes.delete("departuredatetime")
    ride_attributes.delete("created_at")
    ride_attributes.delete("updated_at")

    cookies[:ride] = "#{ride_attributes.to_s}, return_trip_checkbox=>#{ride_return_trip_checkbox}, departuredatetime=>#{ride_departuredatetime}, return_departuredatetime=>#{ride_return_departuredatetime}".gsub("nil", "").strip

  end

  def store_ride_participants(ride_participant) # Ride Participant store in cookies
    cookies[:ride_participant] = ride_participant.attributes.to_s
  end

  def retrieve_ride # Retrieve ride from cookies in to hash function
    to_hash(cookies[:ride])
  end

  def retrieve_participant # Retrieve ride_participant with respect to rides from cookies in to hash function
    to_hash(cookies[:ride_participant])
  end

  def clear_participant # clear the cookies of ride_particpant
    cookies[:ride_participant] = nil
  end

  def clear_ride # clear the cookies of rides
    cookies[:ride] = nil
  end

  def get_proper_attributes
    unless params[:ride].blank?
      params[:ride][:departuredatetime] = "#{params[:ride][:departure_date]} #{params[:ride][:new_departure_time]} #{params[:ride][:ampm_time]}"
      params[:ride].delete(:departure_date)
      params[:ride].delete(:new_departure_time)
      params[:ride].delete(:ampm_time)
    end
  end

  def require_login
    @ride = Ride.new(retrieve_ride)
    @ride.return_departuredatetime = @ride.return_departuredatetime.to_time rescue @ride.return_departuredatetime = nil
    get_proper_attributes
    unless params[:ride].blank?
      @ride.attributes = params[:ride]
    end
    store_ride(@ride)
    super
  end

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "sptest" && password == "helloworld123"
    end
  end
end
