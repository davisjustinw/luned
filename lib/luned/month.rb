class Luned::Month

  attr_reader :time, :days

  @@all = []

  def initialize(year, month)
      @time = Time.new(year.to_i, month.to_i, Time.days_in_month(month.to_i, year.to_i))
      @days = []
      add
  end

  def self.create(year, month)
    self.new(year, month) if valid?(year, month)
  end

  def self.build(year, month)
    binding.pry
  end

  def add
    @@all << self
  end

  def add_day(day)
    Luned::Day.new(self, day).tap { |day| @days << day }
  end

  def minmax_count
    min, max = counts.minmax_by { |day| day["count"].to_i }
    minmax = min["count"].to_i, max["count"].to_i
  end

  def year
    @time.year
  end

  def is
    @time.month
  end

  def self.all
    @@all
  end

  def self.delete_all
    @@all.clear
  end

  def self.valid?(year, month)
    DateTime.valid_date?(year.to_i, month.to_i, -1)
  end

end
