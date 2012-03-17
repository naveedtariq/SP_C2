class Ride < ActiveRecord::Base
  after_find do |ride|
    ride.departure_time = "2012-03-06 13:00:00 +0000".to_time if ride.departure_time.blank?
  end
  has_many :ride_participants
  has_many :users, :through => :ride_participants
  validates  :available_seats, :total_price, :departure_date, :departure_time, :duration_in_minutes, :ride_type, :presence => true
  validate :departure_date_inclusion
  validate :from_and_to_location
  def from_and_to_location
    errors.add(:from_location_id, "can't be same as destination") if(self.from_location_id == self.to_location_id)
  end
  def departure_date_inclusion
    errors.add(:departure_date, "must be within a year") if(self.departure_date && (self.departure_date > (SpClock.date + 1.year)))
#    errors.add(:departure_date, "can't be before today") if(self.departure_date && (self.departure_date < (SpClock.date)))
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
  scope :active, where( :status => STATUS_FOR_RIDES[:active] )
  scope :current_rides, where("departure_date >= ?", SpClock.date)
  scope :orderby_date, order("departure_date ASC")
  scope :orderby_time, order("departure_time ASC")
  scope :orderby_price, order("total_price ASC")
  belongs_to :to_location, :class_name => Location
  belongs_to :from_location, :class_name => Location
  #accepts_nested_attributes_for :location
  # attr_accessible :from_city, :to_city, :departure_date, :departure_time, :flexibility, :duration, :ride_type, :available_seats, :total_price, :notes
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
    rides.current_rides.active.orderby_date.orderby_time.orderby_price.includes(:ride_participants)
  end
  def ride_participants_owners
    if self.ride_participants.blank?
      self.ride_participants
    else
      self.ride_participants.owners
    end
  end
  def change_owner!
    riders = self.ride_participants_owners
    riders.update_all(:role => ROLES_FOR_RIDES[:abandoned])
    rider = self.ride_participants.pending_or_confirmed.first
    rider.update_attribute(:role, ROLES_FOR_RIDES[:owner] ) unless rider.blank?
  end
  def make_owner!(user)
    riders = self.ride_participants_owners
    riders.update_all(:role => ROLES_FOR_RIDES[:abandoned])
    self.users << user
  end
  def owner
    User.find_by_id(self.ride_participants.owner && self.ride_participants.owner.user_id)
  end
  def remaining_seats
    self.available_seats - booked_seats
  end
  def booked_seats
    self.ride_participants.pending_or_confirmed.sum(:number_of_seats)
  end
  def active_participants
    self.ride_participants.active_participants.pluck("users.first_name").join(", ")
  end
  def modify!(params, user_id)
    if self.ride_participants.pending_or_confirmed.blank?
      self.update_attributes!(params)
    else 
      User.find(user_id).rides << Ride.create!(params)
      self.change_owner!
    end
  end
  def cancel!
    self.status = STATUS_FOR_RIDES[:canceled]
    self.save!
  end
  def per_price_seat
    if remaining_seats > 0
      self.total_price/remaining_seats
    end
  end
end