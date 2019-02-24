
class Weather911::Day
  attr_accessor :observed, :hours
  @@all = []

  def initialize(year, month, day)
      @date = Date.new(year.to_i, month.to_i, day.to_i)
      @hours = []
      add_day
  end

  def add_day
    @@all << self
  end

  def add_hour(hour)
    hour.day = self
    @hours << hour
  end

  def include?(hour)

  end

  def month
    @date.strftime('%b')
  end

  def year
    @date.strftime('%Y')
  end

  def self.get_all
    @@all
  end

  def self.delete_all
    @@all.clear
  end

  def self.valid?(year, month, day)
    Date.valid_date?(year.to_i, month.to_i, day.to_i)
  end

  def self.create(year, month, day)
    self.new(year, month, day) if valid?(year, month, day)
  end

end
