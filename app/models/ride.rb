class Ride < ActiveRecord::Base
  has_many :ride_participants
  has_many :users, :through => :ride_participants
  belongs_to :user
  validates  :available_seats, :price_per_seat, :departure_date, :departure_time, :duration_in_minutes, :ride_type, :presence => true
  validate :departure_date_inclusion
  def departure_date_inclusion
    errors.add(:departure_date, "Departure date must be within a year") if(self.departure_date && (self.departure_date > (Date.today+1.year)))
    errors.add(:departure_date, "Departure date can't be before today") if(self.departure_date && (self.departure_date < (Date.today)))
  end
  attr_accessor :departure, "all"
  validates_numericality_of :available_seats, :greater_than => 0
  validates_numericality_of :price_per_seat, :greater_than_or_equal_to => 0
  validates_numericality_of :flexibility_in_minutes, :greater_than_or_equal_to => 0, :allow_nil => true
  scope :scoped_departure, lambda{ |date_departure| where("departure_date < ?", date_departure)}
  belongs_to :to_location, :class_name => Location
  belongs_to :from_location, :class_name => Location
  #accepts_nested_attributes_for :location
  # attr_accessible :from_city, :to_city, :departure_date, :departure_time, :flexibility, :duration, :ride_type, :available_seats, :price_per_seat, :notes
  def self.search_rides(params)
    unless params.blank?
      params.each do |param|
        params.delete param[0] if param[1].blank?
      end
    end
    departure_date = params && params.delete(:departure) 
#    return self.all if params.blank?
#    departure_date = params.delete(:departure_datetime)
    rides = self.where(params)
    if departure_date && ["this_week", "this_month"].include?(departure_date)
      if departure_date == "this_week"
        dep_date = Date.today + 1.week
      elsif departure_date == "this_month"
        dep_date = Date.today + 1.month
      end  
      rides = rides.scoped_departure(dep_date)
    end
    rides
  end
end