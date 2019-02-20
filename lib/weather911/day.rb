
class Weather911::Day
  attr_accessor :this_date, :incidents, :observations
  @@all = []

  def initialize(year, month, day)
      @this_date = Date.new(year.to_i, month.to_i, day.to_i)
      @incidents = []
      @observations = []
      add_day
  end

  def add_day
    @@all << self
  end

  def month
    @this_date.strftime('%b')
  end

  def year
    @this_date.strftime('%Y')
  end

  def self.get_all
    @@all
  end

  def self.delete_all
    @@all.clear
  end

  def days_in_month
    Date.new(@this_date.year, @this_date.month, -1).day
  end

  def self.valid?(year, month, day)
    Date.valid_date?(year.to_i, month.to_i, day.to_i)
  end

  def self.create(year, month, day)
    self.new(year, month, day) if valid?(year, month, day)
  end

end
