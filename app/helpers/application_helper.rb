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
end
