describe "View" do

  describe "#heat" do
    it "takes a string a value and minmax then applies heat gradient styling" do
      minmax = [221,319]
      hot_string = "Hot, Hot, Hot!"
      values = [221,245,260,275,290,319]

      view = Luned::View.new
      puts ''
      values.each { |x| puts view.add_heat(hot_string, x, minmax)}
      puts ''
    end
  end

  describe "#moon" do
    it "return lunar ansi icon for exact phase of moon" do
      view = Luned::View.new
      phases = [0,0.125,0.25,0.375,0.5,0.625,0.75,0.825,0.95]

      phases.each { |x| print view.moon(x)}
      puts ''
    end

    it "return lunar ansi icon for exact phase of moon" do
      view = Luned::View.new
      phases = [0.01,0.126,0.26,0.374,0.52,0.624,0.76,0.824,0.96,1]

      phases.each { |x| print view.moon(x)}
      puts ''
    end
  end

  describe "#month" do
    it "prints the month with hotness" do
      month = Luned::Month.new(2019,1)

      view = Luned::View.new
      view.month(month)
      puts ''
    end
  end

end
