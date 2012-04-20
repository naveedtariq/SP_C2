class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :save_request                                                   # Require save_request filter
  helper_method :production?
  def save_request
    #    RequestLogger.create!(:request_url => request.url, :user_agent => request.user_agent, :ip_address => request.remote_ip, :referer => request.referer, :cookie_string => request.cookies)            // save the all cookies with ip_address
  end
  def not_authenticated                                                         # if not authenticate user the redirect to login page
    redirect_to login_url
  end
  def production?
    Rails.env == "production"                                                   # define the rails development
  end
  def to_hash(str)
    Hash[str.gsub(/{|}|\"/,"").split(",").map{|m| m.strip.split("=>") }]        # Apply hash function
  end
  def create_or_store_ride(ride)
    cookies[:ride] ||= ride.attributes.to_s.gsub!("nil","")                     # Create and store the post ride information in cookies
  end
  def create_ride_cookie(ride)                                                  # cookies for post ride information save in cookies
    cookies[:ride] = ride.attributes.to_s.gsub!("nil","")
  end
  def store_ride(ride)                                                          # To store the ride information
    ride_departure_date = ride.departure_date.to_s
    ride_attributes = ride.attributes
    ride_attributes.delete("departure_date")
    ride_attributes.delete("departuredatetime")
    ride_attributes.delete("created_at")
    ride_attributes.delete("updated_at")
    cookies[:ride] = "#{ride_attributes.to_s}, departure_date=>#{ride_departure_date}".gsub!("nil", "")
  end
  def store_ride_participants(ride_participant)                                 # Ride Participant store in cookies
    cookies[:ride_participant] = ride_participant.attributes.to_s
  end
  def retrieve_ride                                                             # Retrieve ride from cookies in to hash function
    to_hash(cookies[:ride])
  end
  def retrieve_participant                                                      # Retrieve ride_participant with respect to rides from cookies in to hash function
    to_hash(cookies[:ride_participant])
  end
  def clear_participant                                                         # clear the cookies of ride_particpant
    cookies[:ride_participant] = nil
  end
  def clear_ride                                                                # clear the cookies of rides
    cookies[:ride] = nil
  end
end
