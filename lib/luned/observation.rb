## Represents a weather observation.
class Luned::Observation
  attr_reader :time, :summary, :temperature, :pressure

  @@all = {}

  def initialize(time, summary, temperature, pressure)
    @time = time
    @summary = summary
    @temperature = temperature
    @pressure = pressure
    @@all[self.time] = self
  end

  def self.all
    @@all
  end

end
