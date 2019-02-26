class Weather911::Call
  attr_reader :day, :time, :type, :address, :incident_number

  @@all = []

  def initialize(day, time, address, type, incident_number)
    @day = day
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
