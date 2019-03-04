## Top level Data object.  Holds Day objects and holds a bulk of the methods
# responsible for GET calls to API.
class Luned::Month

  attr_reader :time, :days
  # @@all and collections of most objects like @days use hashes for speed and
  # tighter calls.
  @@all = {}
  @@api = Luned::API.new

  def initialize(time)
    @time = time
    @days = {}
    add
  end

  def self.new_with_int(year, month)
    # Initialize a Month with integers instead of a time object.  Will convert
    # string parameters to ints.  Day is instansiated to number of days in the
    # month to make some calcs later on cleaner.
    self.new(Time.new(year.to_i, month.to_i, Time.days_in_month(month.to_i, year.to_i)))
  end

  def self.create(year, month)
    # Same as above but with validation.
    self.new_with_int(year.to_i, month.to_i) if valid?(year, month)
  end

  def self.get_or_build(year, month)
    # Return appropriate Month object or build one from API
    time = Time.new(year.to_i, month.to_i, Time.days_in_month(month.to_i, year.to_i))
    if @@all.key?(time)
      @@all[time]
    else
      build_from_api(year, month)
    end
  end

  def self.build_from_api(year, month)
    # Instantiate Month object populating with 911 call data.
    create(year, month).tap do |month|
      @@api.get_call_data(month)

      # While buffer is full, pull rows and create Call objects.
      # #new_call sets off a cascade of method calls to create parent objects where
      # none exist.
      while !@@api.call_rows.empty? do
        row = @@api.next_call_row
        month.new_call(row[:time], row[:address], row[:type], row[:incident_number])
      end
    end
  end

  # Get or build cascade
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
  # End get or build cascade

  def count_calls
    # Number of 911 call in the month.
    days.inject(0) { |sum, day| sum += day.count }
  end

  def minmax_count
    # Minimum and Maximum call sums for the month. Used for add_heat in View.
    min, max = days.minmax_by { |day| day.last.count }
    minmax = min.last.count, max.last.count
  end

  # Support methods

  def add
    @@all[self.time] = self
  end

  def self.all
    @@all
  end

  def year
    @time.year
  end

  def is
    @time.month
  end

  def self.valid?(year, month)
    DateTime.valid_date?(year.to_i, month.to_i, -1)
  end

end
