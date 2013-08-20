module EventsHelper


  def display_date(date)
    date_end_string = 'th'
    case date.day % 10
    when 1
      date_end_string = 'st'
    when 2
      date_end_string = 'nd'
    when 3
      date_end_string = 'rd'
    end
    date_end_string = 'th' if date.day == 11 || date.day == 12 || date.day == 13
    display_string = date.strftime("%b. %-d#{ date_end_string }")
    d = date.to_date
    t = date.strftime("%l:%M %P")
    if d == Date.today
      display_string = "Today, #{ t }"
    elsif d == Date.tomorrow
      display_string = "Tomorrow, #{ t }"
    elsif d < Date.today
      display_string = "Already passed"
    elsif d <= Date.today.end_of_week
      display_string = d.strftime("%A") + ", #{ t }"
    end
    return display_string
  end

end
