class Weather911::Call
  attr_reader :time, :type, :address, :report_address, :incident_number

  @@all = []

  def initialize(time, address, type, report_address, incident_number)
    @time = time
    @address = address
    @type = type
    @report_address = report_address
    @incident_number = incident_number
    @@all << self
  end

  def self.all
    @@all
  end

  def date_string
    @time.strftime("%Y %m %d")
  end

  def self.during(time)
    Time.zone = "Pacific Time (US & Canada)"
    @@all.select do |call|
      call.date_string == time.strftime("%Y %m %d")
    end
  end

end
