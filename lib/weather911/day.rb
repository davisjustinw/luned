
class Weather911::Day
  attr_accessor :summary, :high, :low, :pressure, :moonphase
  attr_reader :time
  @@all = []

  def initialize(year, month, day)
      @time = Time.new(year.to_i, month.to_i, day.to_i)
      add_day
  end

  def observations
    Weather911::Observation.during(time)
  end

  def calls
    Weather911::Call.during(time)
  end

  def observations_during_hour(hour)

  end

  def calls_during_hour(hour)

  end

  def add_day
    @@all << self
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

  def self.get_all
    @@all
  end

  def self.delete_all
    @@all.clear
  end

  def self.valid?(year, month, day)
    DateTime.valid_date?(year.to_i, month.to_i, day.to_i)
  end

  def self.create(year, month, day)
    self.new(year, month, day) if valid?(year, month, day)
  end

end
