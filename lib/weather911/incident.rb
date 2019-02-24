class Weather911::Incident
  attr_accessor :type, :address
  def initialize(type, address)
    @type = type
    @address = address
  end

end
