class Ride < ActiveRecord::Base
  has_many :ride_participants
  has_many :users, :through => :ride_participants
  belongs_to :user
#  has_one :location
  #accepts_nested_attributes_for :location
 # attr_accessible :from_city, :to_city, :departure_date, :departure_time, :flexibility, :duration, :ride_type, :available_seats, :price_per_seat, :notes
end