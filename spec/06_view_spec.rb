describe "View" do

  describe "#heat" do
    it "takes a string a value and minmax then applies heat gradient styling" do
      minmax = [221,319]
      hot_string = "Hot, Hot, Hot!"
      values = [221,245,260,275,290,319]

      view = Weather911::View.new
      puts ''
      values.each { |x| puts view.add_heat(hot_string, x, minmax)}
      puts ''
    end
  end

  describe "#moon" do
    it "return lunar ansi icon for exact phase of moon" do
      view = Weather911::View.new
      phases = [0,0.125,0.25,0.375,0.5,0.625,0.75,0.825,0.95]

      phases.each { |x| print view.moon(x)}
      puts ''
    end

    it "return lunar ansi icon for exact phase of moon" do
      view = Weather911::View.new
      phases = [0.01,0.126,0.26,0.374,0.52,0.624,0.76,0.824,0.96,1]

      phases.each { |x| print view.moon(x)}
      puts ''
    end
  end

  describe "#month" do
    it "prints the month with hotness" do
      month = Weather911::Month.new(2019,1)
      month.incident_sums = [{"count"=>"221", "day"=>"1", "weekday"=>"2"},
         {"count"=>"248", "day"=>"2", "weekday"=>"3"},
         {"count"=>"291", "day"=>"3", "weekday"=>"4"},
         {"count"=>"228", "day"=>"4", "weekday"=>"5"},
         {"count"=>"319", "day"=>"5", "weekday"=>"6"},
         {"count"=>"263", "day"=>"6", "weekday"=>"0"},
         {"count"=>"287", "day"=>"7", "weekday"=>"1"},
         {"count"=>"274", "day"=>"8", "weekday"=>"2"},
         {"count"=>"282", "day"=>"9", "weekday"=>"3"},
         {"count"=>"272", "day"=>"10", "weekday"=>"4"},
         {"count"=>"319", "day"=>"11", "weekday"=>"5"},
         {"count"=>"273", "day"=>"12", "weekday"=>"6"},
         {"count"=>"273", "day"=>"13", "weekday"=>"0"},
         {"count"=>"277", "day"=>"14", "weekday"=>"1"},
         {"count"=>"243", "day"=>"15", "weekday"=>"2"},
         {"count"=>"258", "day"=>"16", "weekday"=>"3"},
         {"count"=>"245", "day"=>"17", "weekday"=>"4"},
         {"count"=>"258", "day"=>"18", "weekday"=>"5"},
         {"count"=>"283", "day"=>"19", "weekday"=>"6"},
         {"count"=>"234", "day"=>"20", "weekday"=>"0"},
         {"count"=>"281", "day"=>"21", "weekday"=>"1"},
         {"count"=>"265", "day"=>"22", "weekday"=>"2"},
         {"count"=>"278", "day"=>"23", "weekday"=>"3"},
         {"count"=>"275", "day"=>"24", "weekday"=>"4"},
         {"count"=>"297", "day"=>"25", "weekday"=>"5"},
         {"count"=>"272", "day"=>"26", "weekday"=>"6"},
         {"count"=>"239", "day"=>"27", "weekday"=>"0"},
         {"count"=>"280", "day"=>"28", "weekday"=>"1"},
         {"count"=>"275", "day"=>"29", "weekday"=>"2"},
         {"count"=>"253", "day"=>"30", "weekday"=>"3"},
         {"count"=>"272", "day"=>"31", "weekday"=>"4"}]
      view = Weather911::View.new
      view.month(month)
      puts ''
    end
  end

end
