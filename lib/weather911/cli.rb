#controller

class Weather911::CLI

  def start
    puts "Follow, me... \u{1F311} \u{1F312} \u{1F313} \u{1F314} \u{1F315} \u{1F316} \u{1F317} \u{1F318}"
    top_menu
    display_month('jan', '2019')
    #month_menu
    #Weather911::API.get_data(ARGV[0])
  end

  def top_menu
    puts "Enter: <mon> <yyyy> or <quit>"

  end

  def display_month(month, year)
    puts ''
    puts "| Su | Mo | Tu | We | Th | Fr | Sa |"
    puts "|    |    |  1 |  2 |  3 |  4 |  5 |"
    puts "|  6 |  7 |  8 |  9 | 10 | 11 | 12 |"
    puts "| 13 | 14 | 15 | 16 | 17 | 18 | 19 |"
    puts "| 20 | 21 | 22 | 23 | 24 | 25 | 26 |"
    puts "| 27 | 28 | 29 | 30 | 21 |    |    |"
    #c = Weather911::Color.new
    binding.pry
  end
end
