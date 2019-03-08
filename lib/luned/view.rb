## Displays prompted data.
# #display prints view based on breadcrumb state.
# When local memory doesn't hold the appropriate object view calls the data model objects
# to build themselves calling the API when needed.
class Luned::View

  def greeting
    print "\n\n==============  Luned  =============="
    print "\n\n     \u{1F311} \u{1F312} \u{1F313} \u{1F314} \u{1F315} \u{1F316} \u{1F317} \u{1F318} \u{1F311}"
    print "\n\n======  Seattle 911 + Weather  ======\n\n"
    print " - 01 July 2010 to Present\n"
    print " - <..> move up one layer\n"
    print " - <q> quit.\n"
    print " - Examples:\n   - 2010 7\n   - 2010 7 4\n\n"
  end

  def credits
    print "\n======================================\n\n"
    print "Powered by\n\n"
    print " - Dark Sky:\n    https://darksky.net/poweredby\n\n"
    print " - Socrata & The City of Seattle:\n    https://dev.socrata.com/foundry/data.seattle.gov/grwu-wqtk\n\n"
    print " - Justin Davis, 2019:\n    https://github.com/davisjustinw/luned\n\n"
  end

  def display(args)
    # Gets or builds data objects based on breadcrumb state,
    # building weather and call data as needed.
    case args.size
    when 2
      month(Luned::Month.get_or_build(*args))
    when 3
      time = Time.new(*args)
      Luned::Month.get_or_build(time.year, time.month).\
        get_or_new_day(time).tap do |obj|
          obj.build_observations_as_needed
          day(obj)
        end
    when 4
      time = Time.new(*args)
      Luned::Month.get_or_build(time.year, time.month).tap do |obj|
        obj.get_or_new_day(time).tap do |obj|
          obj.build_observations_as_needed
          hour(obj.get_or_new_hour(time))
        end
      end
    else
      nil
    end
  end

  def month(month)
    # Display month object.  Red background intensifies with increased call counts
    # using add_heat.
    print "\n"
    print " ------------- #{month.time.strftime("%b %Y")} ------------- \n\n"
    print " | Su | Mo | Tu | We | Th | Fr | Sa | \n "
    # Position day 1 under the correct weekday.
    calendar = "|    " * Time.new(month.year, month.is, 1).wday
    
    (1..month.time.end_of_month.day).each do |day|
      if month.days[day]
        day = month.days[day]
        # Add red backgrounds and leading zeros
        entry = add_heat(day.is.to_s.rjust(2,"0"), day.count, month.minmax_count)
        calendar += "| #{entry} "
        # End of the week newline

        calendar += "| \n " if day.weekday == 6
      else
        #no data
        calendar += "| ** "
        #account for end of week
        calendar += "| \n " if Time.new(month.year, month.is, day).wday == 6
      end
    end
    print calendar
    print "\n"
    print " ------------------------------------\n\n"
  end

  def day(day)
    # Display day object.  Red background intensifies with increased call counts
    # using add_heat.  Display summary weather data and lunar phase for the day.
    print "\n"
    print "-------------- #{day.time.strftime("%d %b %Y")} --------------\n\n"
    chart = day.hours.inject("") do |chart, hour|
      hour = hour.last
      time = hour.time
      entry = add_heat(time.strftime("%H:%M"), hour.count, day.minmax_count)
      chart += "| #{entry} "
      chart +=  "| \n" if (time.hour + 1) % 5 == 0
      chart
    end
    print "#{chart}\n"
    print "-----------------------------------------\n\n"
    print "#{moon(day.moonphase)} - #{day.low}F #{day.high}F - #{day.pressure}mb\n"
    print "#{day.summary}\n"
    print "Total: #{day.count} calls\n\n"

  end

  def hour(hour)
    # Display 911 call detail with hourly weather entry.
    print "\n"
    print "-------------- #{hour.time.strftime("%d %b %Y %H:%M %Z")} --------------\n\n"
    hour.calls.each do |call|
      print "#{call.time.strftime("%H:%M")} - #{call.incident_number} - #{call.type} - #{call.address}\n"
    end
    print "\n---------------------------------------------------\n"
    print "#{hour.observation.summary} - #{hour.observation.temperature}F - #{hour.observation.pressure}mb\n"
    print "Total: #{hour.count} calls\n"
    print "\n"
  end

  ## Support methods

  def moon(phase)
    # Displays ANSI moon phase emoji based on each 1/8th lunar phase.
    icons = {"0.0"=>"\u{1F311}", "0.125"=>"\u{1F312}", "0.25"=>"\u{1F313}", "0.375"=>"\u{1F314}", "0.5"=>"\u{1F315}", "0.625"=>"\u{1F316}", "0.75"=>"\u{1F317}", "0.875"=>"\u{1F318}", "1.0"=>"\u{1F311}"}
    icons[phase.round_to(0.125).to_s]
  end

  def add_heat(text, value, minmax)
    # Applies red background with increasing intensity to text based on value's
    # relationship with min and max.
    min, max = minmax
    colors = ['16','52','88','124','160','196']
    section = (max - min) / 6.0
    color_hash = {}
    colors.each.with_index(1) {|x, i| color_hash[(i * section) + min] = x}
    color_code = color_hash.detect { |x| value <= x.first }.last
    "\e[48;5;#{color_code}m#{text}\e[0m"
  end

end
