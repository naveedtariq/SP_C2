class Ride < ActiveRecord::Base
  has_many :ride_participants
  has_many :users, :through => :ride_participants
  belongs_to :user
  validates :from_city, :to_city, :available_seats, :price_per_seat, :departure_datetime, :arrival_datetime, :ride_type, :presence => true
  validates_numericality_of :available_seats, :greater_than => 0
  validates_numericality_of :price_per_seat, :greater_than_or_equal_to => 0
  validates_numericality_of :flexibility, :greater_than_or_equal_to => 0
#  has_one :location
  #accepts_nested_attributes_for :location
 # attr_accessible :from_city, :to_city, :departure_date, :departure_time, :flexibility, :duration, :ride_type, :available_seats, :price_per_seat, :notes
end