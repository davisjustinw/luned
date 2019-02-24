class Weather911::Month

  attr_accessor :this_date, :incident_sums

  @@all = []

  def initialize(year, month)
      @datetime = DateTime.new(year.to_i, month.to_i, -1)
      @incident_sums = []
      @days = []
      add_month
  end

  def add_month
    @@all << self
  end

  def add_sum(sum)
    @incident_sums << sum
  end

  def minmax_count
    min, max = incident_sums.minmax_by { |day| day["count"].to_i }
    minmax = min["count"].to_i, max["count"].to_i
  end

  def self.get_all
    @@all
  end

  def self.delete_all
    @@all.clear
  end

  def days_in_month
    @datetime.day
  end

  def self.valid?(year, month)
    DateTime.valid_date?(year.to_i, month.to_i, -1)
  end

  def self.create(year, month)
    self.new(year, month) if valid?(year, month)
  end

##########################################################
=begin
  def month
    @datetime.strftime('%b')
  end

  def year
    @datetime.strftime('%Y')
  end

  def first_datetime
    DateTime.new(@datetime.year, @datetime.month, 1)
  end

  def last_int
    @datetime.day
  end

  def weekday(day)
    (first_day + (day - 1)).strftime('%w').to_i
  end
=end
end
