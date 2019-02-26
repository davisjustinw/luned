class Luned::API

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

  def get_calls(month)
    Time.zone = "Pacific Time (US & Canada)"
    start = Time.utc(month.year, month.is)
    finish = start.end_of_month.in_time_zone
    start = start.in_time_zone
    str = "$select=datetime,address,type,incident_number"
    str += "&$where=datetime "
    str += "between '#{start.year}-#{start.month}-#{start.day}T#{start.hour}:#{start.min}:00.000' "
    str += "and '#{finish.year}-#{finish.month}-#{finish.day}T#{finish.hour}:#{finish.min}:00.000'"
    str += "&$order=datetime&$limit=20000"
    query = URI.encode(str)
    parameter = "#{@seattle_url}#{query}&#{@seattle_token}"
    HTTParty.get("#{@seattle_url}#{query}").parsed_response
  end

  def create_calls(month)
    Time.zone = "Pacific Time (US & Canada)"
    get_calls(month).each do |call|
      time = Time.strptime(call["datetime"], "%Y-%m-%dT%H:%M:%S.%L").utc.to_s
      time = Time.strptime(time, "%Y-%m-%d %H:%M:%S UTC").in_time_zone
      Luned::Call.new(time, call["address"], call["type"], call["incident_number"])
    end
  end

  def get_weather(year, month, day)
    location = "47.609400,-122.336345"
    time = Time.new(year, month, day).utc.to_i.to_s
    url = "#{@weather_url}#{@weather_token}/#{location},#{time}?exclude=flags,offset"
    HTTParty.get(url).parsed_response
  end

  def create_observations(year, month, day)

    Luned::Day.create(year, month, day).tap do |new_day|
      response = get_weather(year, month, day)
      daily = response["daily"]["data"].first
      new_day.summary = daily["summary"]
      new_day.high = daily["temperatureHigh"]
      new_day.low = daily["temperatureLow"]
      new_day.pressure = daily["pressure"]
      new_day.moonphase = daily["moonPhase"]

      hourly = response["hourly"]["data"]

      hourly.each do |obs|
        time = Time.strptime(obs["time"].to_s, "%s").in_time_zone
        Luned::Observation.new(time, obs["summary"], obs["temperature"], obs["pressure"])
      end
    end
  end

end
