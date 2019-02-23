describe "Hour" do
  describe "#new" do
    it "initializes an hour object with an int representing and hour between 0 and 24" do
      hour = Weather911::Hour.new(4)

      expect(hour.is).to eq(4)
    end
  end
end
