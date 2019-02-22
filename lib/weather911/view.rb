class Weather911::View

  def initialize
  end

  def display

  end
  def month(month)
    calendar = ["| Su ", "| Mo ", "| Tu ", "| We ", "| Th ", "| Fr ", "| Sa ", "| \n "]
    #puts "| Su | Mo | Tu | We | Th | Fr | Sa |"
    #puts "|    |    |  1 |  2 |  3 |  4 |  5 |"
    #puts "|  6 |  7 | #{red(' 8')} |  9 | 10 | 11 | 12 |"
    #puts "| 13 | 14 | 15 | 16 | 17 | 18 | 19 |"
    #puts "| 20 | 21 | 22 | #{green('23')} | 24 | 25 | 26 |"
    #puts "| 27 | 28 | 29 | 30 | 31 |    |    |"
    #puts ''


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

  def colorize(text, color_code)
    "\e[30;#{color_code}m#{text}\e[0m"
  end

  def red(text); colorize(text, "101"); end
  def yellow(text); colorize(text, "103"); end
  def green(text); colorize(text, "102"); end
end
