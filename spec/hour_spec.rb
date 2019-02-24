describe "Hour" do
  describe "#new" do
    it "initializes an hour object with a breadcrumb" do
      hour = Weather911::Hour.new("2019", "2", "1", "13")

      expect(hour.is).to eq("13")
    end
  end

  describe "::in_day" do
    it "returns array of Hours from a given month" do
      hour = Weather911::Hour.new("2019", "2", "2", "13")
      hour2 = Weather911::Hour.new("2019", "2", "2", "14")
      hour3 = Weather911::Hour.new("2019", "1", "4", "13")

      day_hours = Weather911::Hour.in_day("2019", "2", "2")

      expect(day_hours).to include(hour)
      expect(day_hours).not_to include(hour3)
    end
  end


end
