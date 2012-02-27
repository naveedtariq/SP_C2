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
end