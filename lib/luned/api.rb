## Calls APIs adjusts to Seattle local time and doles out data rows one by one.

class Luned::API
  attr_reader :call_rows, :hourly_observation_rows

  def initialize
    # Pull Socrata and Dark Sky Tokens from .env
    if ENV['dark_sky']
      @socrata = "$$app_token=#{ENV['socrata']}"
    else
      @socrata = ''
    end

    if ENV['dark_sky']
      @dark_sky = ENV['dark_sky']
    else
      @dark_sky = ''
    end
      @seattle_url = "https://data.seattle.gov/resource/grwu-wqtk.json?"
      @weather_url = "https://api.darksky.net/forecast/"

    @call_rows = []
    @hourly_observation_rows = []
  end

  def get_call_data(month)
    # Gets a month's worth of call data from Socrata.  Socrata allows more granular
    # queries however the timezone formmatting for this dataset made that impractical.
    # The data set was recorded at Pacific time but the server treats it as UTC.
    # Example: A call at 0900 Pacific is actually recorded as 0900 UTC in the system.  So to pull
    # a day's rows requires offsetting by -7 or -8 hours in the query.

    # Set timezone to force Time objects to Pacific time when calling #in_time_zone
    Time.zone = "Pacific Time (US & Canada)"

    # Time objects for beginning and end of month set to proper offset.
    start = Time.utc(month.year, month.is)
    finish = start.end_of_month.in_time_zone
    start = start.in_time_zone

    # Build the query
    str = "$select=datetime,address,type,incident_number"
    str += "&$where=datetime "
    str += "between '#{start.year}-#{start.month}-#{start.day}T#{start.hour}:#{start.min}:00.000' "
    str += "and '#{finish.year}-#{finish.month}-#{finish.day}T#{finish.hour}:#{finish.min}:00.000'"
    str += "&$order=datetime&$limit=20000"

    # Encode whitespace etc. to escape characters
    query = URI.encode(str)
    parameter = "#{@seattle_url}#{query}&#{@socrata}"
    @call_rows += HTTParty.get("#{@seattle_url}#{query}").parsed_response
  end

  def next_call_row
    # Pulls a row from the buffer and creates a hash with an Time object adjusted
    # for timezone.
    Time.zone = "Pacific Time (US & Canada)"
    if @call_rows
      row = @call_rows.shift

      # This is gross but the only way found to force a string to UTC then
      # to Pacific time adjusting for the non-utc utc entries coming from the API.
      time = Time.strptime(row["datetime"], "%Y-%m-%dT%H:%M:%S.%L").utc.to_s
      time = Time.strptime(time, "%Y-%m-%d %H:%M:%S UTC").in_time_zone
      {time: time, address: row["address"], type: row["type"], incident_number: row["incident_number"]}
    end
  end

  def get_weather_data(year, month, day)
    # GETs day's weather observations for given coordinates.
    # GPS coordinates of Flatiron Seattle Campus :).
    location = "47.609400,-122.336345"

    # Dark_Sky times are UTC.
    time = Time.new(year, month, day).utc.to_i.to_s

    url = "#{@weather_url}#{@dark_sky}/#{location},#{time}?exclude=flags,offset"
    response = HTTParty.get(url).parsed_response

    # Store observations to buffer and returns daily summary data.
    @hourly_observation_rows += response["hourly"]["data"]
    response["daily"]["data"].first
  end

  def next_hourly_observation_row
    # Pulls a row from the buffer and creates a hash with an Time object adjusted
    # for timezone.
    Time.zone = "Pacific Time (US & Canada)"
    if @hourly_observation_rows
      row = @hourly_observation_rows.shift
      time = Time.strptime(row["time"].to_s, "%s").in_time_zone
      {time: time, summary: row["summary"], temperature: row["temperature"], pressure: row["pressure"]}
    end
  end

end
