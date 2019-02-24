class Weather911::Hour
  attr_accessor :incidents, :observed, :day

  def initialize(year, month, day, hour)
    @datetime = DateTime.new(year, month, day, hour)
    @incidents = []
  end

  def is
    @datetime.strftime("%H")
  end

  def add_incident(incident)
    @incidents << incident
  end

  def create_incident(type, address)
    add_incident(Weather911::Incident.new(type, address))
  end

end
