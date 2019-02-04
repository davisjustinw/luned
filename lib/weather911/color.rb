#class Weather911::Color
  def colorize(text, color_code)
    "\e[30;#{color_code}m#{text}\e[0m"
  end

  def red(text); colorize(text, "101"); end
  def yellow(text); colorize(text, "103"); end
  def green(text); colorize(text, "102"); end

#end
