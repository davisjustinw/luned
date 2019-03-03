class Luned::Hour
  attr_reader :calls, :time, :observation, :day

  @@all = {}

  def initialize(time)
    @time = time
    @calls = []
  end

  def self.new_with_int(year, month, day, hour)
    self.new(Time.new(year, month, day, hour))
  end

  def add
    @@all[self.time] = self
  end

  def count
    @calls.size
  end

  def new_call(time, address, type, incident_number)
    Luned::Call.new(time, address, type, incident_number).tap { |call| @calls << call }
  end

  def new_observation(time, summary, temperature, pressure)
    Luned::Observation.new(time, summary, temperature, pressure).tap { |obs| @observation = obs }
  end

  def self.all
    @@all
  end

end
