#controller

class Weather911::CLI
  @@PROMPTS = ["<yyyy>", "<mm>", "<dd>", "<hr24>"]
  attr_accessor :breadcrumb

  def initialize
    @breadcrumb = []
    @inputs = []
  end

  def start
    puts ''
    puts "    Follow, me...\u{1f407}"
    puts "\u{1F311} \u{1F312} \u{1F313} \u{1F314} \u{1F315} \u{1F316} \u{1F317} \u{1F318} \u{1F311}"
    puts ''
    prompt

    #Weather911::API.get_incidents(ARGV[0])
  end

  def display_prompts
    print  "#{@@PROMPTS[@breadcrumb.size..-1].join(" ")}: "
  end

  def prompt
    input = ''
    until input == 'q' do
      display_prompts
      input = gets.chomp
      if input !=  'q'
        parse_input(input)
        display_month('feb')
      end
    end
  end

  def parse_input(input)
    input.split
  end

  def valid_year?(input)
    input.to_i.between?(2003, Date.today.year)
  end

  def valid_month?(input)
      int = input.to_i
      year = @breadcrumb.first
      min_date = Date.new(2003, 11)
      input_date = Date.new(year, int) if int.between?(1,12)
      input_date && input_date.between?(min_date, Date.today)
  end

  def valid_day?(input)
    int = input.to_i
    year, month = @breadcrumb
    min_date = Date.new(2003, 11, 7)
    input_date = Date.new(year, month, int) if Date.valid_date?(year, month, int)
    input_date && input_date.between?(min_date, Date.today)
  end

  def hour?(int)
    int.between?(0,23) if int
  end

  def before_today?
    Date.new(@breadcrumb[0], @breadcrumb[1], @breadcrumb[2]) < Date.today
  end

  def integer(input)
    input.to_i if input.to_i.to_s == input
  end

  def valid_hour?(input)
    int = integer(input)
    year, month, day = @breadcrumb
    this_datetime = DateTime.new(year, month, day, int) if hour?(int)
    now = DateTime.now
    if this_datetime && this_datetime.to_date == now.to_date && int < now.hour
      true
    elsif this_datetime && this_datetime.to_date < now.to_date
      true
    else
      false
    end
  end

  def up(input)
    while input.first == '..'
      input.shift
      @breadcrumb.pop
    end
    input
  end

  def valid_input?(input)
    case @breadcrumb.size
    when 0
      valid_year?(input)
    when 1
      valid_month?(input)
    when 2
      valid_day?(input)
    when 3
      valid_hour?(input)
    else
      false
    end
  end

  def display_month(month)

    puts "| Su | Mo | Tu | We | Th | Fr | Sa |"
    puts "|    |    |  1 |  2 |  3 |  4 |  5 |"
    puts "|  6 |  7 | #{red(' 8')} |  9 | 10 | 11 | 12 |"
    puts "| 13 | 14 | 15 | 16 | 17 | 18 | 19 |"
    puts "| 20 | 21 | 22 | #{green('23')} | 24 | 25 | 26 |"
    puts "| 27 | 28 | 29 | 30 | 31 |    |    |"
    puts ''

    prompt_day('feb')
  end

  def display_day(day)
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

  def display_hour(hour)
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
