describe "Hour" do

  describe "#new" do
    it "initializes with a Day object and hour int" do
      month = Luned::Month.new(2019, 2)
      day = Luned::Day.new(month, 3)
      hour = Luned::Hour.new(day, 4)
      binding.pry

      expect(hour).to be_an_instance_of(Luned::Hour)
    end
  end

  describe "#new_call" do
    #need to fix
    it "creates new call and adds it to the day" do
      month = Luned::Month.new(2019, 2)
      day = Luned::Day.new(month, 3)
      call = day.new_call('2345', '1234 bob', 'aid', '12345')

      expect(call).to be_an_instance_of(Luned::Call)
      expect(day.calls).to include(call)
    end
  end

  describe "#new_observation" do
    #need to fix
    it "creates new observation and adds it to the day" do
      month = Luned::Month.new(2019, 2)
      day = Luned::Day.new(month, 3)
      observation = day.new_observation(2300, 'Cloudy', '43', '1001')

      expect(observation).to be_an_instance_of(Luned::Observation)
      expect(day.observations).to include(observation)
    end
  end
end
