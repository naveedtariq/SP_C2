class Ride < ActiveRecord::Base
  after_find do |ride|
    ride.new_departure_time = "01:00" if ride.new_departure_time.blank?
  end
  attr_accessor :friends_in_common
  attr_accessor :count
  attr_accessor :return_trip_checkbox
  attr_accessor :return_trip_departure_date
  attr_accessor :return_trip_departure_time
  attr_accessor :new_departure_time
  attr_accessor :departure_date
  attr_accessor :ampm_time

  attr_accessor :return_new_departure_time
  attr_accessor :return_new_ampm_time
  attr_accessor :return_departuredatetime

  scope :past_rides, lambda { |ride_departure_time|
    where("rides.departuredatetime < ?", ride_departure_time)
  }
  scope :sorted_recent_at_top, order("departuredatetime Desc")

  has_many :ride_participants # Association with ride_participants model
  has_many :users, :through => :ride_participants # Association with user model
  validates :available_seats, :total_price, :duration_in_minutes, :ride_type, :presence => true
  validate :departure_date_inclusion
  validate :from_and_to_location #Validation
  def price_per_seat(number_of_seats = 1)
    (self.total_price/(self.ride_participants.active_participants.count + number_of_seats))
  end

  def active?
    (((self.departuredatetime - Time.zone.now) > 0) && self.status == 1)
  end

  def from_and_to_location #check for if from and to location names are same
    errors.add(:from_location_id, "can't be same as destination") if (self.from_location_id == self.to_location_id)
  end

  def departure_date_inclusion #Departure date check must be with in year
    errors.add(:departuredatetime, "must be within a year") if (self.departuredatetime && (self.departuredatetime > (SpClock.date + 1.year)))
                               #    errors.add(:departure_date, "can't be before today") if(self.departure_date && (self.departure_date < (SpClock.date)))
  end

  attr_accessor :departure, "all"

  def duration_hours # show hours of the time
    self.duration_in_minutes && (self.duration_in_minutes / 60)
  end

  def duration_minutes # show the minutes only
    self.duration_in_minutes && (self.duration_in_minutes % 60)
  end

  def duration_hours=(dur_hr)
    self.duration_in_minutes ||= 0
    self.duration_in_minutes = (dur_hr.to_i*60) + self.duration_in_minutes
  end

  def duration_minutes=(dur_min)
    self.duration_in_minutes ||= 0
    self.duration_in_minutes = dur_min.to_i
  end

  validates_numericality_of :available_seats, :greater_than => 0 # check the input is numerical based or not
  validates_numericality_of :total_price, :greater_than_or_equal_to => 0 # check the input is numerical based or not
  validates_numericality_of :flexibility_in_minutes, :greater_than_or_equal_to => 0, :allow_nil => true # check the input is numerical based or not

  scope :scoped_departure, lambda { |date_departure| where("departuredatetime < ?", date_departure) } #Select rides where departure date have been passed
  scope :scoped_departuredatetime, lambda { |date_departure| where("departuredatetime >= ? and departuredatetime < ?", date_departure, (date_departure+1.days)) } #Select rides where departure date have been passed
  scope :active, where(:status => STATUS_FOR_RIDES[:active]) # Select rides where status is '1', '1' for active
  scope :current_rides, lambda { |ride_departure_time| where("departuredatetime >= ?", ride_departure_time)} # Select current rides where departure date is today date or coming date
  scope :orderby_time, order("departuredatetime ASC") # order the rides by departure_time in Ascending ordered
  scope :orderby_price, order("total_price ASC") # order the rides by total_price in Ascending ordered

  belongs_to :to_location, :class_name => Location # Association with Location model
  belongs_to :from_location, :class_name => Location # Association with Location model

  has_many :messages # Association with messages
  has_many :feedbacks # Association with feedback

  #accepts_nested_attributes_for :location
  # attr_accessible :from_city, :to_city, :departure_date, :departure_time, :flexibility, :duration, :ride_type, :available_seats, :total_price, :notes

  def self.search_rides(params) # Search rides by specific date, next 15 and 30 days
    unless params.blank?
      params.each do |param|
        params.delete param[0] if param[1].blank?
      end
    end
    departure_date = params && params.delete(:departure)
    departuredate_time = params && params.delete(:departuredatetime)
    rides = self.where(params)
    rides = rides.scoped_departuredatetime(departuredate_time.to_time) if departuredate_time.present?
    if departure_date && ["first_option", "second_option"].include?(departure_date)
      if departure_date == "first_option"
        dep_date = SpClock.date + SEARCH_OPTION_ONE_IN_DAYS.days
      elsif departure_date == "second_option"
        dep_date = SpClock.date + SEARCH_OPTION_TWO_IN_DAYS.days
      end
      rides = rides.scoped_departure(dep_date)
    end
    rides.current_rides(SpClock.time).active.orderby_time.orderby_price.includes(:ride_participants)
  end


  def ride_participants_owners # Return the ride owner
    if self.ride_participants.blank?
      self.ride_participants
    else
      self.ride_participants.owners
    end
  end

  def change_owner! # Change the owner of the ride
    riders = self.ride_participants_owners
    old_owner = riders && riders.first.user
    riders.update_all(:role => ROLES_FOR_RIDES[:abandoned])
    rider = self.ride_participants.pending_or_confirmed.first
    unless rider.blank?
      rider.update_attribute(:role, ROLES_FOR_RIDES[:owner])
      UserMailer.owner_change_email(old_owner, self).deliver
    end
  end

  def make_owner!(user) # Changes the owner to user
    riders = self.ride_participants_owners
    riders.update_all(:role => ROLES_FOR_RIDES[:abandoned])
    self.users << user
  end

  def owner # return the rides of owner
    User.find_by_id(self.ride_participants.owner && self.ride_participants.owner.user_id)
  end

  def remaining_seats # return the remaining seat of total available seats
    self.available_seats - booked_seats
  end

  def booked_seats # return the total number of booked seats
    self.ride_participants.pending_or_confirmed.sum(:number_of_seats)
  end

  def active_participants # return the active_participants of ride
    self.ride_participants.active_participants.pluck("users.first_name").join(", ")
  end

  def modify!(params, user_id) # modify the ride
    if self.ride_participants.pending_or_confirmed.blank?
      self.update_attributes!(params)
      return nil
    else
      ride = Ride.create!(self.attributes)
      ride.update_attributes!(params)
      User.find(user_id).rides << ride
      self.change_owner!
      reture ride.id
    end
  end

  def cancel! # return the cancel status of ride
    self.status = STATUS_FOR_RIDES[:canceled]
    self.save!
  end

  def per_price_seat # return the price per seat
    if remaining_seats > 0
      self.total_price/remaining_seats
    end
  end

  def price_per_seat_with_owner
    self.total_price / ((self.available_seats) + 1)
  end

  def actual_departure_time
    self.departure_time.change(:year => self.departure_date.year, :day => self.departure_date.day, :month => self.departure_date.month )
  end
end
