class SpClock
  def self.time                     # return current time
    Time.zone.now
  end
  def self.date                     # return date
    Time.zone.today
  end
  def self.day                      # return day
    23.hours + 59.minutes
  end
end