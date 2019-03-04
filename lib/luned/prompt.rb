## Controls User input and breadcrumb Navigation
# PROMPTS: Template for visual prompt
# Breadcrumb: Current state or data level
# Args: Buffer for un-validated user input

class Luned::Prompt
  @@PROMPTS = ["<yyyy>", "<mm>", "<dd>", "<hr24>"]
  attr_reader :breadcrumb, :args

  def initialize
    @breadcrumb = []
    @args = []
  end

  def display_breadcrumb
    # Prints current level and prompt for deeper level
    print "#{@breadcrumb.join(" ")} #{@@PROMPTS[@breadcrumb.size..-1].join(" ")}: "
  end

  def get_args
    # user input
    @args = gets.chomp.split
  end

  def quit?
    true if args.detect { |arg| arg.downcase == 'q'}
  end

  def valid_args?
    # test for 'q', '..', and integers.
    @args.all? {|arg| arg =~/q|[..]|[0-9]+$*/}
  end

  def submit_args
    # Moves up the domain model validates, and adds to current state.
    up
    @args.each do |arg|
        arg.to_i.tap do |int|
          valid_time?(int) ? @breadcrumb << int : break
        end
    end
    @args.clear
  end

  def valid_time?(arg)
    # Validate accoording to breadcrumb state.
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

  def valid_year?(int)
    int.between?(2010, Time.now.year)
  end

  def valid_month?(int)
      year = @breadcrumb.first
      input_date = Time.new(year, int) if int.between?(1,12)
      input_date && input_date.between?(min_date, Time.now)
  end

  def valid_day?(int)
    year, month = @breadcrumb
    input_date = Date.new(year, month, int) if DateTime.valid_date?(year, month, int)
    input_date && input_date.between?(min_date, Time.now)
  end

  def valid_hour?(int)
    year, month, day = @breadcrumb
    this_datetime = Time.new(year, month, day, int) if hour?(int)
    now = Time.now
    if this_datetime && this_datetime.to_date == now.to_date && int < now.hour
      true
    elsif this_datetime && this_datetime.to_date < now.to_date
      true
    else
      false
    end
  end

  def pop_hour
    # Pops the hour off breadcrumb to allow repeated hour displays.
    @breadcrumb.pop if @breadcrumb.size == @@PROMPTS.size
  end

  ## Support methods

  def up
    # Handles navigation up the domain model.
    while @args.first == '..'
      @args.shift
      @breadcrumb.pop
    end
  end

  def hour?(int)
    int.between?(0,23) if int
  end

  def min_date
    # Earliest consistent entries in the 911 data.
    # Tests for valid calendar entries as well as scope of data.
    Time.new(2010, 7, 1)
  end

end
