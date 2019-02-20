class Weather911::Prompt
  @@PROMPTS = ["<yyyy>", "<mm>", "<dd>", "<hr24>"]
  attr_accessor :breadcrumb, :arg, :args

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

  def quit?
    true if arg.downcase == 'q'
  end

  def valid_year?(int)
    int.between?(2003, Date.today.year)
  end

  def valid_month?(int)
      year = @breadcrumb.first
      min_date = Date.new(2003, 11)
      input_date = Date.new(year, int) if int.between?(1,12)
      input_date && input_date.between?(min_date, Date.today)
  end

  def valid_day?(int)
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

  def int_from(arg)
    arg.to_i if arg.to_i.to_s == arg
  end

  def submit_args
    up
    @args.each do |arg|
        int_from(arg).tap do |int|
          valid_arg?(int) ? @breadcrumb << int : break
        end
    end
    @args.clear
  end

  def valid_hour?(int)
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

  def up
    while @args.first == '..'
      @args.shift
      @breadcrumb.pop
    end
  end

  def valid_arg?(arg)
    case @breadcrumb.size
    when 0
      valid_year?(arg)
    when 1
      valid_month?(arg)
    when 2
      valid_day?(arg)
    when 3
      valid_hour?(arg)
    else
      false
    end
  end

end
