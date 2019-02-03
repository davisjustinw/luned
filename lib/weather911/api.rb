class Weather911::API

  def self.get_data(token)
    client = SODA::Client.new({:domain => "opendata.socrata.com", :app_token => token})

    results = client.get("4fng-4fdn", :$limit => 5000)
    #binding.pry
    puts "Got #{results.body.count} results. Dumping first results:"
    results.body.first.each do |k, v|
      puts "#{k}: #{v}"
    end
  end
end
