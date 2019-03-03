describe "View" do
  month = Luned::Month.build_from_api(2019,1)
  view = Luned::View.new
  month.days[1].build_observations

  describe "#heat" do
    it "takes a string a value and minmax then applies heat gradient styling" do
      minmax = [221,319]
      hot_string = "Hot, Hot, Hot!"
      values = [221,245,260,275,290,319]
      puts ''
      values.each { |x| puts view.add_heat(hot_string, x, minmax)}
      puts ''
    end
  end

  describe "#moon" do
    it "return lunar ansi icon for exact phase of moon" do

      phases = [0,0.125,0.25,0.375,0.5,0.625,0.75,0.825,0.95]
      phases.each { |x| print view.moon(x)}
      puts ''
    end

    it "return lunar ansi icon for exact phase of moon" do
      phases = [0.01,0.126,0.26,0.374,0.52,0.624,0.76,0.824,0.96,1]
      phases.each { |x| print view.moon(x)}
      puts ''
    end
  end

  describe "#month" do
    it "prints the month with hotness" do
      view.month(month)
      puts ''
    end
  end

  describe "#day" do
    it "print the day with hotness" do
      view.day(month.days[1])
      puts ''
    end
  end

  describe "#hour" do
    it "print the hours observation and calls" do
      view.hour(month.days[1].hours[0])
    end
  end

end
