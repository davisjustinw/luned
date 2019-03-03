class Luned::Call
  attr_reader :time, :type, :address, :incident_number

  @@all = []

  def initialize(time, address, type, incident_number)
    #@hour = hour
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
