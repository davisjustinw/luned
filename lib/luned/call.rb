class Luned::Call
  attr_reader :hour, :time, :type, :address, :incident_number

  @@all = []

  def initialize(hour, time, address, type, incident_number)
    @hour = hour 
    @time = time
    @address = address
    @type = type
    @incident_number = incident_number
    @@all << self
  end

  def self.all
    @@all
  end

end
