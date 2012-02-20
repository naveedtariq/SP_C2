class Location < ActiveRecord::Base
  has_many :to_rides, :class_name => Ride, :foreign_key => "to_location_id"
  has_many :from_rides, :class_name => Ride, :foreign_key => "from_location_id"
end
