describe "Hour" do
  describe "#new" do
    it "initializes an hour object with a breadcrumb" do
      hour = Weather911::Hour.new(2019, 2, 1, 13)

      expect(hour.is).to eq("13")
    end
  end

  describe "::in_month" do
    it "returns array of Hours from a given month" do
      hour = Weather911::Hour.new(2019, 2, 2, 13)
      hour2 = Weather911::Hour.new(2019, 2, 3, 13)
      hour3 = Weather911::Hour.new(2019, 1, 4, 13)

      month_hours = Weather911::Hour.in_month(2019, 2)

      expect(month_hours).to include(hour)
      expect(month_hours).not_to include(hour3)
    end
  end


end
