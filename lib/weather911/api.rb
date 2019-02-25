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
    Time.zone = "Pacific Time (US & Canada)"
    start = Time.utc(year, month)
    finish = start.end_of_month.in_time_zone
    start = start.in_time_zone
    str = "$select=datetime,address,type,incident_number&$where=datetime between '#{start.year}-#{start.month}-#{start.day}T#{start.hour}:#{start.min}:00.000' and '#{finish.year}-#{finish.month}-#{finish.day}T#{finish.hour}:#{finish.min}:00.000'&$order=datetime&$limit=20000"

    #select = "SELECT datetime, address, type, incident_number"
    #where = "WHERE datetime BETWEEN"
    #wherestart = "'#{start.year}-#{start.month}-#{start.day}T#{start.hour}:#{start.min}:00.000'"
    #wherefinish = "'#{finish.year}-#{finish.month}-#{finish.day}T#{finish.hour}:#{finish.min}:00.000'"
    #group = "ORDER BY datetime"
    #query = URI.encode("$query=#{select} #{where} #{wherestart} AND #{wherefinish} #{group} LIMIT=20000")
    query = URI.encode(str)
    parameter = "#{@seattle_url}#{query}&#{@seattle_token}"
    response = HTTParty.get("#{@seattle_url}#{query}").parsed_response
    response
  end

  def create_month(year, month)
    response = get_month(year, month)
    month_obj = Weather911::Month.new(year, month)
    response.each { |count| month_obj.add_count(count) }
    month_obj
  end

  def get_day_calls(year, month, day)
    Time.zone = "Pacific Time (US & Canada)"
    start = Time.utc(year, month, day)
    finish = start.end_of_day.in_time_zone
    start = start.in_time_zone
    select = "SELECT datetime, address, type, incident_number"
    where = "WHERE datetime BETWEEN"
    wherestart = "'#{start.year}-#{start.month}-#{start.day}T#{start.hour}:#{start.min}:00.000'"
    wherefinish = "'#{finish.year}-#{finish.month}-#{finish.day}T#{finish.hour}:#{finish.min}:00.000'"
    group = "ORDER BY datetime"
    query = URI.encode("$query=#{select} #{where} #{wherestart} AND #{wherefinish} #{group}")
    parameter = "#{@seattle_url}#{query}&#{@seattle_token}"
    HTTParty.get("#{@seattle_url}#{query}").parsed_response
  end

  def get_day_weather(year, month, day)
    location = "47.609400,-122.336345"
    time = Time.new(year, month, day).utc.to_time.to_i.to_s
    url = "#{@weather_url}#{@weather_token}/#{location},#{time}?exclude=flags,offset"
    HTTParty.get(url).parsed_response
  end

  def create_day(year, month, day)
    Time.zone = "Pacific Time (US & Canada)"
    get_day_calls(year, month, day).each do |call|
      #.in_time_zone
      time = Time.strptime(call["datetime"], "%Y-%m-%dT%H:%M:%S.%L")
      Weather911::Call.new(time, call["address"], call["type"], call["incident_number"])
    end

    Weather911::Day.create(year, month, day).tap do |new_day|
      response = get_day_weather(year, month, day)
      daily = response["daily"]["data"].first
      new_day.summary = daily["summary"]
      new_day.high = daily["temperatureHigh"]
      new_day.low = daily["temperatureLow"]
      new_day.pressure = daily["pressure"]
      new_day.moonphase = daily["moonPhase"]

      hourly = response["hourly"]["data"]

      hourly.each do |obs|
        time = Time.strptime(obs["time"].to_s, "%s").in_time_zone
        Weather911::Observation.new(time, obs["summary"], obs["temperature"], obs["pressure"])
      end
    end
  end

end
