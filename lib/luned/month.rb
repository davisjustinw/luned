class Luned::Month

  attr_reader :time, :days

  @@all = []
  @@api = Luned::API.new

  def initialize(year, month)
      @time = Time.new(year.to_i, month.to_i, Time.days_in_month(month.to_i, year.to_i))
      @days = []
      add
  end

  def self.create(year, month)
    self.new(year, month) if valid?(year, month)
  end

  def self.build(year, month)
    create(year, month).tap do |month|
      day = nil
      @@api.get_call_rows(month)
      while !@@api.call_rows.empty? do
        row = @@api.next_call_row
        day = month.add_day(row[:time].day) if !day || day.is != row[:time].day
        day.new_call(row[:time], row[:address], row[:type], row[:incident_number])
      end
    end
  end

  def count_calls
    days.inject(0) { |sum, day| sum += day.count }
  end

  def add
    @@all << self
  end

  def add_day(day)
    Luned::Day.new(self, day).tap { |day| @days << day }
  end

  def minmax_count
    min, max = days.minmax_by { |day| day.count }
    minmax = min.count, max.count
  end

  def year
    @time.year
  end

  def is
    @time.month
  end

  def first_day
    @time - (@time.day - 1)
  end

  def weekday(day)
    (first_day + (day - 1)).strftime('%w').to_i
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
