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
    response.each { |sum| month_obj.add_sum(sum) }
    month_obj
  end

  def get_day_ems(year, month, day)
    select = "SELECT date_extract_hh(datetime) as hour, count(*)"
    where = "WHERE date_trunc_ymd(datetime) = '#{year}-#{month}-#{day}T00:00:00.000'"
    group = "GROUP BY hour ORDER BY hour"
    query = URI.encode("$query=#{select} #{where} #{group}")
    parameter = "#{@seattle_url}#{query}&#{@seattle_token}"
    HTTParty.get("#{@seattle_url}#{query}").parsed_response
  end

  def get_day_weather(year, month, day)
    location = "47.609400,-122.336345"
    time = DateTime.new(year, month, day).to_time.to_i.to_s
    url = "#{@weather_url}#{@weather_token}/#{location},#{time}?exclude=currently,flags,offset,hourly"
    HTTParty.get(url).parsed_response["daily"]["data"].first
  end

  def create_day(year, month, day)
    #needs work
    Weather911::Day.new(year, month, day).tap do |day|
      day.observation = get_day_weather(year, month, day)

    end
  end

  def get_hour_ems(year, month, day, hour)
    select = "SELECT datetime, type, address"
    where = "WHERE date_trunc_ymd(datetime) ="
    filter = "'#{year}-#{month}-#{day}T00:00:00.000'"
    andfilter = "AND date_extract_hh(datetime) = #{hour}"
    group = "ORDER BY datetime"
    query = URI.encode("$query=#{select} #{where} #{filter} #{andfilter} #{group}")
    parameter = "#{@seattle_url}#{query}&#{@seattle_token}"
    HTTParty.get("#{@seattle_url}#{query}").parsed_response
  end

  def get_hour_weather(year, month, day, hour)
    location = "47.609400,-122.336345"
    time = DateTime.new(year, month, day, hour).to_time.to_i.to_s
    url = "#{@weather_url}#{@weather_token}/#{location},#{time}?exclude=flags,offset,daily,hourly"
    HTTParty.get(url).parsed_response
  end

end
