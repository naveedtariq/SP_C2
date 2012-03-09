class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :save_request
  helper_method :production?
  def save_request
#    return render :text => request.cookies
    RequestLogger.create!(:params => request.inspect, :request_url => request.url, :user_agent => request.user_agent, :ip_address => request.remote_ip, :referer => request.referer, :cookie_string => request.cookies)
  end
  def not_authenticated
    redirect_to login_url, :alert => "First login to access this page."
  end
  def production?
    Rails.env == "production"
  end
  def to_hash(str)
    Hash[str.gsub(/{|}|\"/,"").split(",").map{|m| m.strip.split("=>") }]
  end
  def create_or_store_ride(ride)
    cookies[:ride] ||= ride.attributes.to_s.gsub!("nil","")
  end
  def store_ride(ride)
    ride_departure_date = ride.departure_date.to_s
    ride_attributes = ride.attributes
    ride_attributes.delete("departure_date")
    cookies[:ride] = "#{ride_attributes.to_s}, departure_date=>#{ride_departure_date}".gsub!("nil", "")
  end
  def store_ride_participants(ride_participant)
    cookies[:ride_participant] = ride_participant.attributes.to_s
  end
  def retrieve_ride
    to_hash(cookies[:ride])
  end
  def retrieve_participant
    to_hash(cookies[:ride_participant])
  end
  def clear_participant
    cookies[:ride_participant] = nil
  end
  def clear_ride
    cookies[:ride] = nil
  end
end
