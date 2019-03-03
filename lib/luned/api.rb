class Luned::API

  attr_reader :call_rows, :hourly_observation_rows

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

    @call_rows = []
    @hourly_observation_rows = []
  end

  def get_call_rows(month)
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
    @call_rows += HTTParty.get("#{@seattle_url}#{query}").parsed_response
  end

  def next_call_row
    Time.zone = "Pacific Time (US & Canada)"
    if @call_rows
      row = @call_rows.shift
      time = Time.strptime(row["datetime"], "%Y-%m-%dT%H:%M:%S.%L").utc.to_s
      time = Time.strptime(time, "%Y-%m-%d %H:%M:%S UTC").in_time_zone
      {time: time, address: row["address"], type: row["type"], incident_number: row["incident_number"]}
    end
  end

  def get_weather(year, month, day)
    location = "47.609400,-122.336345"
    time = Time.new(year, month, day).utc.to_i.to_s
    url = "#{@weather_url}#{@weather_token}/#{location},#{time}?exclude=flags,offset"
    response = HTTParty.get(url).parsed_response
    @hourly_observation_rows += response["hourly"]["data"]
    response["daily"]["data"].first
  end

  def next_hourly_observation_row
    Time.zone = "Pacific Time (US & Canada)"
    if @hourly_observation_rows
      row = @hourly_observation_rows.shift
      time = Time.strptime(row["time"].to_s, "%s").in_time_zone
      {time: time, summary: row["summary"], temperature: row["temperature"], pressure: row["pressure"]}
    end
  end

end
