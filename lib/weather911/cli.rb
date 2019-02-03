#controller
class Weather911::CLI

  def start
    puts "Follow, me... \u{1F311} \u{1F312} \u{1F313} \u{1F314} \u{1F315} \u{1F316} \u{1F317} \u{1F318}"
    top_menu
    display_month
    month_menu
    #Weather911::API.get_data(ARGV[0])
  end

  def top_menu
    puts "Enter: <mon> <yyyy> or <quit>"
    
  end

  def display_month(month, year)

  end
end
