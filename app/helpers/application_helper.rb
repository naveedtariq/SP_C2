module ApplicationHelper

  def location_options_for_select(selected_key=nil)
    options_for_select(Location.all.collect{|l| [l.name, l.id, {:group=> l.group,:loc=>l.google_helper}]},selected_key)
  end

  def time_to_minutes(t)                                                        # function for time change to in minutes
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
  def number_of_records(page, per_page, offset = 1)                             # function for count records per page in search rides results
    if page.blank?
      "1"
    else
      (((page.to_i-1) * per_page.to_i) + offset).to_s
    end
  end
  def secs_to_time(seconds)                                                     # function for convert seconds in proper time 
    minutes = seconds/60
    mins = (minutes%60).to_i
    hours = (minutes/60).to_i
    days = (hours/24).to_i
    hours = (hours%24).to_i
    "#{days}d #{hours}h #{mins}m"
  end

  def body_css_class(css_class)
    @body_css_class = css_class
  end

end


