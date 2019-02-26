describe "Observation" do
  describe ".new" do
    it "initializes Observation" do
      month = Weather911::Month.create(2019, 2)
      day = Weather911::Day.new(month, 1)
      observation = Weather911::Observation.new(day, 2300, 'Cloudy', '43', '1001')
      expect(observation).to be_an_instance_of(Weather911::Observation)
    end
  end
end
