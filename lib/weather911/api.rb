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

  def get_month(breadcrumb)
    select = "SELECT date_extract_d(datetime) as day, count(*)"
    where = "WHERE date_trunc_ym(datetime) = '#{breadcrumb[0]}-#{breadcrumb[1]}-01T00:00:00.000'"
    group = "GROUP BY day ORDER BY day"
    query = URI.encode("$query=#{select} #{where} #{group}")
    parameter = "#{@seattle_url}#{query}&#{@seattle_token}"
    HTTParty.get("#{@seattle_url}#{query}").parsed_response
  end

  def get_day_ems(breadcrumb)
    select = "SELECT date_extract_hh(datetime) as hour, count(*)"
    where = "WHERE date_trunc_ymd(datetime) = '#{breadcrumb[0]}-#{breadcrumb[1]}-#{breadcrumb[2]}T00:00:00.000'"
    group = "GROUP BY hour ORDER BY hour"
    query = URI.encode("$query=#{select} #{where} #{group}")
    parameter = "#{@seattle_url}#{query}&#{@seattle_token}"
    HTTParty.get("#{@seattle_url}#{query}").parsed_response
  end

  def get_hour_ems(breadcrumb)
    select = "SELECT datetime, type, address"
    where = "WHERE date_trunc_ymd(datetime) ="
    filter = "'#{breadcrumb[0]}-#{breadcrumb[1]}-#{breadcrumb[2]}T00:00:00.000'"
    andfilter = "AND date_extract_hh(datetime) = #{breadcrumb[3]}"
    group = "ORDER BY datetime"
    query = URI.encode("$query=#{select} #{where} #{filter} #{andfilter} #{group}")
    parameter = "#{@seattle_url}#{query}&#{@seattle_token}"
    HTTParty.get("#{@seattle_url}#{query}").parsed_response
  end

  def get_day_weather(breadcrumb)
    location = "47.609400,-122.336345"
    time = DateTime.new(breadcrumb[0], breadcrumb[1], breadcrumb[2]).to_time.to_i.to_s
    url = "#{@weather_url}#{@weather_token}/#{location},#{time}?exclude=currently,flags,offset,hourly"
    HTTParty.get(url).parsed_response
  end

  def get_hour_weather(breadcrumb)
    location = "47.609400,-122.336345"
    time = DateTime.new(breadcrumb[0], breadcrumb[1], breadcrumb[2], breadcrumb[3]).to_time.to_i.to_s
    url = "#{@weather_url}#{@weather_token}/#{location},#{time}?exclude=flags,offset,daily,hourly"
    HTTParty.get(url).parsed_response
  end

end
