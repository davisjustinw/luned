
describe "Observation" do
  describe ".new" do
    it "initializes Observation" do
      time = Time.now
      observation = Luned::Observation.new(time, 'Cloudy', '43', '1001')
      expect(observation).to be_an_instance_of(Luned::Observation)
    end
  end
end
