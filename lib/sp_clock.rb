class SpClock
  def self.time
    Time.now
  end
  def self.date
    Date.today
  end
  def self.day
    23.hours + 59.minutes
  end
  def self.zone_offset
    Time.now.in_time_zone("Eastern Time (US & Canada)").zone
    end
  def self.time_with_zone
    Time.now.in_time_zone("Eastern Time (US & Canada)")
  end
end