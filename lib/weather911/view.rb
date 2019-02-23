class Weather911::View

  def initialize
  end

  def display

  end
  def month(month)
    calendar = ["| Su ", "| Mo ", "| Tu ", "| We ", "| Th ", "| Fr ", "| Sa ", "| \n "]
    calendar += Array.new(month.weekday(1), "|    ")
    month.incident_sums.each do |hash|
      day = add_heat(hash["day"].rjust(2,"0"),hash["count"].to_i,month.minmax_count)
      calendar << "| #{day} "
      calendar << "| \n " if hash["weekday"].to_i == 6
    end
    calendar.each { |x| print x }
  end


  def day(day)
    #puts  (0..24).inject('|') { |phrase, hour| "#{phrase}#{hour.to_s.rjust(2, "0")}00|"}
    puts "\u{1F314}, 50f, 30in"
    puts "| 0000 | 0100 | 0200 | 0300 | 0400 |"
    #puts "|      |      |      |      |      |"
    puts "| 0500 | 0600 | #{red('0700')} | 0800 | 0900 |"
    #puts "|      |      |      |      |      |"
    puts "| 1000 | 1100 | 1200 | 1300 | 1400 |"
    #puts "|      |      |      |      |      |"
    puts "| 1500 | 1600 | 1700 | 1800 | 1900 |"
    #puts "|      |      |      |      |      |"
    puts "| 2000 | 2100 | 2200 | #{green('2300')} |"
    #puts "|      |      |      |      |"

    puts ''
  end

  def hour(hour)
    #display_observation
    #each display_incident
    puts "Temp: 45f, Barometer: 30in, Barometer Change: .5"
    puts "Aid 1, Medic 9, Total 10"
    puts "Aid - 517 3rd Ave - A5"
    puts "Medic - 2030 3rd Ave - M5, E5"
    puts "Medic - 2030 3rd Ave - M5, E5"
    puts "Medic - 2030 3rd Ave - M5, E5"
    puts "Medic - 2030 3rd Ave - M5, E5"
    puts "Medic - 2030 3rd Ave - M5, E5"
    puts "Medic - 2030 3rd Ave - M5, E5"
    puts "Medic - 2030 3rd Ave - M5, E5"
    puts "Medic - 2030 3rd Ave - M5, E5"
    puts "Medic - 2030 3rd Ave - M5, E5"
  end

  def moon(phase)
    icons = {"0.0"=>"\u{1F311}", "0.125"=>"\u{1F312}", "0.25"=>"\u{1F313}", "0.375"=>"\u{1F314}", "0.5"=>"\u{1F315}", "0.625"=>"\u{1F316}", "0.75"=>"\u{1F317}", "0.825"=>"\u{1F318}", "0.95"=>"\u{1F318}", "1.0"=>"\u{1F311}"}
    icons[phase.round_to(0.125).to_s]
  end

  def add_heat(text, value, minmax)
    min, max = minmax
    colors = ['16','52','88','124','160','196']
    section = (max - min) / 6.0
    color_hash = {}
    colors.each.with_index(1) {|x, i| color_hash[(i * section) + min] = x}
    color_code = color_hash.detect { |x| value <= x.first }.last
    "\e[48;5;#{color_code}m#{text}\e[0m"
  end

  def colorize(text, color_code)
    "\e[30;#{color_code}m#{text}\e[0m"
  end

  def red(text); colorize(text, "101"); end
  def yellow(text); colorize(text, "103"); end
  def green(text); colorize(text, "102"); end
end
