
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
    self.new(Time.new(year, month, day)) if valid?(year, month, day)
  end

  def new_hour(hour)
    Luned::Hour.new_with_int(year, month, is, hour.hour).tap do |hour|
      @hours[hour.time.hour] = hour
    end
  end

  def get_or_new_hour(time)
    hour(time) || new_hour(time)
  end

  def hour(time)
    hours[time.hour] if hours.key?(time.hour)
  end

  def build_observations
    daily = @@api.get_weather(year, month, is)
    @summary = daily["summary"]
    @high = daily["temperatureHigh"]
    @low = daily["temperatureLow"]
    @pressure = daily["pressure"]
    @moonphase = daily["moonPhase"]

    while !@@api.hourly_observation_rows.empty? do
      row = @@api.next_hourly_observation_row
      new_hour(row[:time]) if !hours.key?(row[:time].hour)
      hours[row[:time].hour].new_observation(row[:time], row[:summary], row[:temperature], row[:pressure])
    end
  end

  def count
    hours.inject(0) { |count, hour| count + hour.last.count }
  end

  def is
    @time.day
  end

  def month
    @time.month
  end

  def year
    @time.year
  end

  def add
    @@all[self.time] = self
  end

  def weekday
    @time.strftime("%w").to_i
  end

  def minmax_count
    min, max = hours.minmax_by { |hour| hour.last.count }
    minmax = min.last.count, max.last.count
  end

  def self.all
    @@all
  end

  def self.valid?(year, month, day)
    DateTime.valid_date?(year, month, day)
  end

end
