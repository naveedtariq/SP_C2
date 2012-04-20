class SpClock
  def self.time                     # return current time
    Time.now
  end
  def self.date                     # return date
    Date.today
  end
  def self.day                      # return day
    23.hours + 59.minutes
  end
  def self.zone_offset                                        # return time zone of EST
    Time.now.in_time_zone("Eastern Time (US & Canada)").zone
    end
  def self.time_with_zone                                     # return time w.r.t zone EST
    Time.now.in_time_zone("Eastern Time (US & Canada)")
  end
end