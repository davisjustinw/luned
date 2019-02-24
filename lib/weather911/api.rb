class Weather911::API

  def initialize
    if ENV['seattle_token']
      @seattle_token = "$$app_token=#{ENV['seattle_token']}"
    else
      @seattle_token = ''
    end

    if ENV['dark_sky']
      @weather_token = ENV['dark_sky']
    else
      @weather_token = ''
    end
      @seattle_url = "https://data.seattle.gov/resource/grwu-wqtk.json?"
      @weather_url = "https://api.darksky.net/forecast/"

  end

  def get_month(year, month)
    #select = "SELECT date_extract_d(datetime) as day, date_extract_dow(datetime) as weekday, count(*)"
    select = "SELECT count(*), date_extract_d(datetime) as day, date_extract_dow(datetime) as weekday"
    where = "WHERE date_trunc_ym(datetime) = '#{year}-#{month}-01T00:00:00.000'"
    group = "GROUP BY day, weekday ORDER BY day"
    query = URI.encode("$query=#{select} #{where} #{group}")
    parameter = "#{@seattle_url}#{query}&#{@seattle_token}"
    HTTParty.get("#{@seattle_url}#{query}").parsed_response
  end

  def create_month(year, month)
    response = get_month(year, month)
    month_obj = Weather911::Month.new(year, month)
    response.each { |count| month_obj.add_count(count) }
    month_obj
  end

  def get_day_calls(year, month, day)
    select = "SELECT datetime, address, type "
    where = "WHERE date_trunc_ymd(datetime) = '#{year}-#{month}-#{day}T00:00:00.000'"
    group = "ORDER BY datetime"
    query = URI.encode("$query=#{select} #{where} #{group}")
    parameter = "#{@seattle_url}#{query}&#{@seattle_token}"
    HTTParty.get("#{@seattle_url}#{query}").parsed_response
  end

  def get_day_weather(year, month, day)
    location = "47.609400,-122.336345"
    time = DateTime.new(year, month, day).to_time.to_i.to_s
    url = "#{@weather_url}#{@weather_token}/#{location},#{time}?exclude=currently,flags,offset"
    HTTParty.get(url).parsed_response
  end

  def create_day(year, month, day)
    #needs work
    #create Day
    #add weather observation
    #add counts
    Weather911::Day.new(year, month, day).tap do |day|
      weather = get_day_weather(year, month, day)
      calls = get_day_calls(year, month, day)
    end
  end

end
