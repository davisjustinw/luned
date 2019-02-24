
class Weather911::Day
  attr_accessor :observed
  @@all = []

  def initialize(year, month, day)
      @datetime = DateTime.new(year.to_i, month.to_i, day.to_i)
      add_day
  end

  def add_day
    @@all << self
  end

  def hours
    Weather911::Hour.in_day(year, month, day)
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

  def self.get_all
    @@all
  end

  def self.delete_all
    @@all.clear
  end

  def self.valid?(year, month, day)
    DateTime.valid_date?(year.to_i, month.to_i, day.to_i)
  end

  def self.create(year, month, day)
    self.new(year, month, day) if valid?(year, month, day)
  end

end
