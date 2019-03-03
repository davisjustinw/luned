describe "Observation" do
  describe ".new" do
    it "initializes Observation" do
      month = Luned::Month.create(2019, 2)
      day = Luned::Day.new(month, 1)
      observation = Luned::Observation.new(day, 2300, 'Cloudy', '43', '1001')
      expect(observation).to be_an_instance_of(Luned::Observation)
    end
  end
end
