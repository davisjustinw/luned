class Weather911::Hour
  attr_accessor :incidents, :observed

  @@all = []

  def initialize(year, month, day, hour)
    @datetime = DateTime.new(year.to_i, month.to_i, day.to_i, hour.to_i)
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

  def day
    @datetime.day
  end

  def is
    @datetime.hour
  end

  def self.in_day(year, month, day)
    year, month, day = year.to_i, month.to_i, day.to_i
    all.select do |hour|
      year == hour.year && month == hour.month && day == hour.day
    end
  end

  def add_incident(incident)
    @incidents << incident
  end

  def create_incident(type, address)
    add_incident(Weather911::Incident.new(type, address))
  end

end
