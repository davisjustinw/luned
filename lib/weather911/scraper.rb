class Weather911::Scraper

  def self.get_incidents(token = nil)
    if token
      token_parameter = "?$$app_token=#{token}"
    else
      token_parameter = ''
    end
    url = "https://opendata.socrata.com/resource/4fng-4fdn.json#{token_parameter}"
    puts url
    HTTParty.get(url)
  end
end
