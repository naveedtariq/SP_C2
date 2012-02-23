class Ride < ActiveRecord::Base
  has_many :ride_participants
  has_many :users, :through => :ride_participants
  belongs_to :user
  validates  :available_seats, :total_price, :departure_date, :departure_time, :duration_in_minutes, :ride_type, :presence => true
  validate :departure_date_inclusion
  validate :from_and_to_location
  def from_and_to_location
    errors.add(:from_location_id, "can't be same as destination") if(self.from_location_id == self.to_location_id)
  end
  def departure_date_inclusion
    errors.add(:departure_date, "must be within a year") if(self.departure_date && (self.departure_date > (SpClock.date + 1.year)))
    errors.add(:departure_date, "can't be before today") if(self.departure_date && (self.departure_date < (SpClock.date)))
  end
  attr_accessor :departure, "all"
  def duration_hours
    self.duration_in_minutes && (self.duration_in_minutes / 60)
  end
  def duration_minutes
    self.duration_in_minutes && (self.duration_in_minutes % 60)
  end
  def duration_hours=(dur_hr)
    self.duration_in_minutes ||= 0
    self.duration_in_minutes = (dur_hr.to_i*60) + self.duration_in_minutes
  end
  def duration_minutes=(dur_min)
    self.duration_in_minutes ||= 0
    self.duration_in_minutes = dur_min.to_i + self.duration_in_minutes
  end
  
  validates_numericality_of :available_seats, :greater_than => 0
  validates_numericality_of :total_price, :greater_than_or_equal_to => 0
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
    rides = self.where(params)
    if departure_date && ["first_option", "second_option"].include?(departure_date)
      if departure_date == "first_option"
        dep_date = SpClock.date + SEARCH_OPTION_ONE_IN_DAYS.days
      elsif departure_date == "second_option"
        dep_date = SpClock.date + SEARCH_OPTION_TWO_IN_DAYS.days
      end  
      rides = rides.scoped_departure(dep_date)
    end
    rides
  end
end