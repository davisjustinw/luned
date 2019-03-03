describe "Hour" do

  describe "#new" do
    it "initializes with a time object" do
      hour = Luned::Hour.new(Time.now)
      expect(hour).to be_an_instance_of(Luned::Hour)
    end
  end

end
