class Weather911::Observation
  attr_accessor :summary, :temperature, :pressure

  @@all = []

  def initialize(datetime)
    @datetime = datetime
    @@all << self
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

  def self.during(date)
    @@all.select do |obs|
      obs.year == date.year && obs.month == date.month && obs.year == date.year
    end
  end

end
