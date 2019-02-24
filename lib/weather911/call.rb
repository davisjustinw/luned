class Weather911::Call
  attr_accessor :type, :address

  @@all = []

  def initialize(datetime, address, type)
    @datetime = datetime
    @address = address
    @type = type
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

  def hour
    @datetime.hour
  end

  def self.during(date)
    @@all.select do |call|
      call.year == date.year && call.month == date.month && call.day == date.day
    end
  end

end
