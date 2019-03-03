
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
    Luned::Hour.new_with_int(@time.year, @time.month, @time.day, hour.hour).tap do |hour|
      @hours[hour.time.hour] = hour
    end
  end

  def hour(time)
    hours[time.hour] if hours.key?(time.hour)
  end

  def build_observations
    daily = @@api.get_weather(@time.year, @time.month, @time.day)
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

  def self.include?(time)
    @@all.key?(Time.new(time.year, time.month, time.day))
  end

  def add
    @@all[self.time] = self
  end

  def weekday
    @time.strftime("%w").to_i
  end

  def minmax_count
    #needs work
    (0..23).collect { |hour| count_by_hour(hour) }.minmax
  end

  def self.get(time)
    @@all[Time.new(time.year, time.month, time.day)]
  end

  def self.all
    @@all
  end

  def self.delete_all
    @@all.clear
  end

  def self.valid?(year, month, day)
    DateTime.valid_date?(year, month, day)
  end

end
