class Weather911::CLI

  def start
    puts "Follow, me..."
    token = ARGV[0]
    Weather911::API.get_data(token)
  end
end
