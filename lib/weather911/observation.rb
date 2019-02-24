class Weather911::Observation
  attr_accessor :summary, :temperature, :pressure

  @@all = []

  def initialize(datetime)
    @datetime = datetime
    @@all << self
  end

  def date_string
    @datetime.strftime("%Y %m %d")
  end

  def self.during(date)
    @@all.select do |obs|
      obs.date_string == date.strftime("%Y %m %d")
    end
  end

end
