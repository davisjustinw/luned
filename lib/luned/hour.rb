## Most granular data object abstracting time.  Holds calls and a weather
# observation.
class Luned::Hour
  attr_reader :calls, :time, :observation, :day

  @@all = {}

  def initialize(time)
    @time = time
    @calls = []
  end

  def self.new_with_int(year, month, day, hour)
    # Instantiate with Integers.
    self.new(Time.new(year, month, day, hour))
  end

  def new_call(time, address, type, incident_number)
    # build and add 911 call
    Luned::Call.new(time, address, type, incident_number).tap { |call| @calls << call }
  end

  def new_observation(time, summary, temperature, pressure)
    # build and add weather observation
    Luned::Observation.new(time, summary, temperature, pressure).tap { |obs| @observation = obs }
  end

  def count
    @calls.size
  end

  # Support methods

  def add
    @@all[self.time] = self
  end

  def self.all
    @@all
  end

end
