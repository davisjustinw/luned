class Weather911::Observation
  attr_reader :day, :time, :summary, :temperature, :pressure

  @@all = []

  def initialize(day, time, summary, temperature, pressure)
    @day = day
    @time = time
    @summary = summary
    @temperature = temperature
    @pressure = pressure
    @@all << self
  end

  def self.all
    @@all
  end

end
