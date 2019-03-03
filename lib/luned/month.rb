class Luned::Month

  attr_reader :time, :days

  @@all = {}
  @@api = Luned::API.new

  def initialize(time)
      @time = time
      @days = {}
      add
  end

  def self.new_with_int(year, month)
    self.new(Time.new(year.to_i, month.to_i, Time.days_in_month(month, year)))
  end

  def self.create(year, month)
    self.new_with_int(year.to_i, month.to_i) if valid?(year, month)
  end

  def self.build_from_api(year, month)
    create(year, month).tap do |month|
      @@api.get_call_rows(month)
      while !@@api.call_rows.empty? do
        row = @@api.next_call_row
        month.new_call(row[:time], row[:address], row[:type], row[:incident_number])
      end
    end
  end

  def new_call(time, address, type, incident_number)
    get_or_new_hour(time).new_call(time, address, type, incident_number)
  end

  def get_or_new_hour(time)
    get_or_new_day(time).hour(time) || get_or_new_day(time).new_hour(time)
  end

  def get_or_new_day(time)
    (@days[time.day] if @days.key?(time.day)) || new_day(time.day)
  end

  def new_day(day)
    daytime = Time.new(@time.year, @time.month, day)
    Luned::Day.new(daytime).tap { |day| @days[daytime.day] = day }
  end

  def count_calls
    days.inject(0) { |sum, day| sum += day.count }
  end

  def add
    @@all[self.time] = self
  end

  def minmax_count
    min, max = days.minmax_by { |day| day.last.count }
    minmax = min.last.count, max.last.count
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

  def self.include?(time)
    @@all.key?(Time.new(time.year, time.month))
  end

  def self.delete_all
    @@all.clear
  end

  def self.valid?(year, month)
    DateTime.valid_date?(year.to_i, month.to_i, -1)
  end

end
