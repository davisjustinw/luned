describe "Hour" do
  describe "#new" do
    it "initializes an hour object with a breadcrumb" do
      hour = Weather911::Hour.new(4)

      expect(hour.is).to eq(4)
    end
  end


end
