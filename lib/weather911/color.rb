#class Weather911::Color
  def colorize(text, color_code)
    "\e[1;#{color_code}m#{text}\e[0m"
  end
  def red(text); colorize(text, "31"); end
  def yellow(text); colorize(text, "33"); end
  def green(text); colorize(text, "32"); end

#end
