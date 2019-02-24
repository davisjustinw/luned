class Weather911::Incident
  attr_accessor :type, :address

  def initialize(time, address, type)
    @time = time
    @address = address
    @type = type
  end
end
