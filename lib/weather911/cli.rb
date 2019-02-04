#controller

class Weather911::CLI

  def start
    puts ''
    puts "    Follow, me...\u{1f407}"
    puts "\u{1F311} \u{1F312} \u{1F313} \u{1F314} \u{1F315} \u{1F316} \u{1F317} \u{1F318} \u{1F311}"
    puts ''
    prompt_month
    display_month('jan', '2019')
    prompt_day
    #Weather911::API.get_data(ARGV[0])
  end

  def prompt_month
    print "<mon> <yyyy>: "
    input = gets.chomp
  end

  def display_month(month, year)
    puts "| Su | Mo | Tu | We | Th | Fr | Sa |"
    puts "|    |    |  1 |  2 |  3 |  4 |  5 |"
    puts "|  6 |  7 | #{red(' 8')} |  9 | 10 | 11 | 12 |"
    puts "| 13 | 14 | 15 | 16 | 17 | 18 | 19 |"
    puts "| 20 | 21 | 22 | #{green('23')} | 24 | 25 | 26 |"
    puts "| 27 | 28 | 29 | 30 | 21 |    |    |"
    puts ''
  end

  def prompt_day
    print "<day>: "
    input = gets.chomp
  end

  
end
