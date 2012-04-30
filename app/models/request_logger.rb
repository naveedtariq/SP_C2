class RequestLogger < ActiveRecord::Base
  geocoded_by :ip_address
  after_validation :geocode

  def self.sp_clock_time # return current time
    Time.now
  end

  def self.sp_clock_date # return date
    Date.today
  end

  def self.sp_clock_day # return day
    23.hours + 59.minutes
  end

  def self.sp_clock_zone_offset # return time zone of EST
    Time.now.in_time_zone("Eastern Time (US & Canada)").zone
  end

  def self.sp_clock_time_with_zone # return time w.r.t zone EST
    Time.now.in_time_zone("Eastern Time (US & Canada)")
  end

end
