
class Weather911::Day
  attr_accessor :summary, :high, :low, :pressure, :moonphase, :calls, :observations
  attr_reader :time
  @@all = []

  def initialize(month, day)
      @time = Time.new(month.year, month.is, day.to_i)
      @calls = []
      @observations = []
      add_day
  end

  def add_day
    @@all << self
  end

  def new_call(time, address, type, incident_number)
    Weather911::Call.new(self, time, address, type, incident_number).tap { |call| @calls << call }
  end

  def new_observation(time, summary, temperature, pressure)
    Weather911::Observation.new(self, time, summary, temperature, pressure).tap { |obs| @observations << obs }
  end

  def count
    @calls.size
  end

  def self.all
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
