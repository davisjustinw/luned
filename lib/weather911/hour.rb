class Weather911::Hour
  attr_accessor :incidents, :observed

  @@all = []

  def initialize(year, month, day, hour)
    @datetime = DateTime.new(year, month, day, hour)
    @incidents = []
    @@all << self
  end

  def self.all
    @@all
  end

  def year
    @datetime.year
  end

  def month
    @datetime.month
  end

  def self.in_month(year, month)
    all.select do |hour|
      year == hour.year && month == hour.month 
    end
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
