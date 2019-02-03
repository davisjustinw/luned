class Weather911::CLI

  def start
    puts "Follow, me..."
    Weather911::API.get_data(ARGV[0])
  end
end
