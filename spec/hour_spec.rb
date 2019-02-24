describe "Hour" do
  describe "#new" do
    it "initializes an hour object with a breadcrumb" do
      hour = Weather911::Hour.new(2019, 2, 1, 13)

      expect(hour.is).to eq("13")
    end
  end


end
