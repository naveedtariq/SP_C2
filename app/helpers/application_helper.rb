module ApplicationHelper
  def time_to_minutes(t)
    hours = t/60
    minutes = t%60
    if(hours > 0 && minutes > 0)
      "#{pluralize(hours, "hour")} #{minutes} minutes"
    elsif hours > 0
      "#{pluralize(hours, "hour")}"
    else
      "#{(t%60)} minutes"
    end
  end
  def to_minutes(t)
    if t == 0
      "00"
    else
      "#{t}"
    end
    
  end
  def number_of_records(page, per_page, offset = 1)
    if page.blank?
      "1"
    else
      (((page.to_i-1) * per_page.to_i) + offset).to_s
    end
  end
  def secs_to_time(seconds)
    minutes = seconds/60
    mins = (minutes%60).to_i
    hours = (minutes/60).to_i
    "#{hours}:#{mins}"
  end
end
