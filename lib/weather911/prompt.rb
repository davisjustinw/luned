class Weather911::Prompt
  @@PROMPTS = ["<yyyy>", "<mm>", "<dd>", "<hr24>"]
  attr_accessor :breadcrumb

  def initialize
    @breadcrumb = []
    @args = []
    @arg = ''
  end

  def get_args
    @args = gets.chomp.split
  end

  def display_breadcrumb
    print  "#{@@PROMPTS[@breadcrumb.size..-1].join(" ")}: "
  end

  def valid_year?(input)
    input.to_i.between?(2003, Date.today.year)
  end

  def valid_month?(input)
      int = input.to_i
      year = @breadcrumb.first
      min_date = Date.new(2003, 11)
      input_date = Date.new(year, int) if int.between?(1,12)
      input_date && input_date.between?(min_date, Date.today)
  end

  def valid_day?(input)
    int = input.to_i
    year, month = @breadcrumb
    min_date = Date.new(2003, 11, 7)
    input_date = Date.new(year, month, int) if Date.valid_date?(year, month, int)
    input_date && input_date.between?(min_date, Date.today)
  end

  def hour?(int)
    int.between?(0,23) if int
  end

  def before_today?
    Date.new(@breadcrumb[0], @breadcrumb[1], @breadcrumb[2]) < Date.today
  end

  def int_from(input)
    input.to_i if input.to_i.to_s == input
  end

  def valid_hour?(input)
    int = int_from(input)
    year, month, day = @breadcrumb
    this_datetime = DateTime.new(year, month, day, int) if hour?(int)
    now = DateTime.now
    if this_datetime && this_datetime.to_date == now.to_date && int < now.hour
      true
    elsif this_datetime && this_datetime.to_date < now.to_date
      true
    else
      false
    end
  end

  def up(input)
    while input.first == '..'
      input.shift
      @breadcrumb.pop
    end
    input
  end

  def valid_input?(input)
    case @breadcrumb.size
    when 0
      valid_year?(input)
    when 1
      valid_month?(input)
    when 2
      valid_day?(input)
    when 3
      valid_hour?(input)
    else
      false
    end
  end

end
