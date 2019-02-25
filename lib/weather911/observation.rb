class Weather911::Observation
  attr_reader :time, :summary, :temperature, :pressure

  @@all = []

  def initialize(time, summary, temperature, pressure)
    @time = time
    @summary = summary
    @temperature = temperature
    @pressure = pressure
    @@all << self
  end

  def self.all
    @@all
  end

  def date_string
    @time.strftime("%Y %m %d")
  end

  def self.during(time)
    @@all.select do |obs|
      obs.date_string == time.strftime("%Y %m %d")
    end
  end

end
