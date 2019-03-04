## Data object responsible for holding Hour objects and daily summary weather data.
# Collections use hashes for lookup speed.
class Luned::Day
  attr_accessor :summary, :high, :low, :pressure, :moonphase
  attr_reader :time, :hours, :month
  @@all = {}
  @@api = Luned::API.new

  def initialize(time)
    @time = time
    @hours = {}
    add
  end

  def self.new_with_int(year, month, day)
    # Validate and instantiate with Ints.
    self.new(Time.new(year, month, day)) if valid?(year, month, day)
  end

  def get_or_new_hour(time)
    # Get or add new Hour object.  Part of the build cascade.
    hour(time) || new_hour(time)
  end

  def hour(time)
    # Returns Hour or false if it doesn't exist.
    hours[time.hour] if hours.key?(time.hour)
  end

  def new_hour(hour)
    # Instantiate and add new Hour object.
    Luned::Hour.new_with_int(year, month, is, hour.hour).tap do |hour|
      @hours[hour.time.hour] = hour
    end
  end

  def build_observations
    # Instantiate Observaation objects and populate with weatger data.
    daily = @@api.get_weather_data(year, month, is)

    # Daily summary data.
    @summary = daily["summary"]
    @high = daily["temperatureHigh"]
    @low = daily["temperatureLow"]
    @pressure = daily["pressure"]
    @moonphase = daily["moonPhase"]

    # While the buffer has rows build observations and add to appropriate hour.
    while !@@api.hourly_observation_rows.empty? do
      row = @@api.next_hourly_observation_row
      hours[row[:time].hour].new_observation(row[:time], row[:summary], row[:temperature], row[:pressure])
    end
  end

  def build_observations_as_needed
    # If observations haven't been built build them.
    build_observations if !@summary
  end

  def count
    # Sum of all calls in all hours.
    hours.inject(0) { |count, hour| count + hour.last.count }
  end

  def minmax_count
    # Minimum and maximum call sums.
    min, max = hours.minmax_by { |hour| hour.last.count }
    minmax = min.last.count, max.last.count
  end

  # Support methods

  def add
    @@all[self.time] = self
  end

  def year
    @time.year
  end

  def month
    @time.month
  end

  def is
    @time.day
  end

  def weekday
    @time.strftime("%w").to_i
  end

  def self.all
    @@all
  end

  def self.valid?(year, month, day)
    DateTime.valid_date?(year, month, day)
  end

end
