#require "spec_helper"
describe "Day" do

 describe ".create" do
    it "initializes a day object if the numeric year, month and day are valid" do
      month = Weather911::Month.new(1999, 2)
      expect(Weather911::Day.create(month, '13')).to be_an_instance_of(Weather911::Day)
    end

    it "return falsey if not a valid year, month and day" do
      month = Weather911::Month.new(1999, 2)
      expect(Weather911::Day.create(month, 31)).to be_falsey
    end

    it ".all includes newly created Day object" do
      month = Weather911::Month.new(1999, 2)
      obj = Weather911::Day.create(month, '1')
      expect(Weather911::Day.all).to include(obj)
    end
  end

  describe "#add" do
    it "adds Day to all" do
      month = Weather911::Month.new(2019, 2)
      day = Weather911::Day.new(month, 3)
      day.add
      expect(Weather911::Day.all).to include(day)
    end
  end

  describe "#new_call" do
    it "creates new call and adds it to the day" do
      month = Weather911::Month.new(2019, 2)
      day = Weather911::Day.new(month, 3)
      call = day.new_call('2345', '1234 bob', 'aid', '12345')

      expect(call).to be_an_instance_of(Weather911::Call)
      expect(day.calls).to include(call)
    end
  end

  describe "#new_observation" do
    it "creates new observation and adds it to the day" do
      month = Weather911::Month.new(2019, 2)
      day = Weather911::Day.new(month, 3)
      observation = day.new_observation(2300, 'Cloudy', '43', '1001')

      expect(observation).to be_an_instance_of(Weather911::Observation)
      expect(day.observations).to include(observation)
    end
  end

  describe "#count" do
    it "returns number of calls associated with the day" do
      month = Weather911::Month.create(2019, 2)
      day = Weather911::Day.new(month, 1)
      day.calls = [1,2,3,4]
      expect(day.count).to eq(4)
    end
  end

  describe ".delete_all" do
    it ".all return an empty array after call" do
      month = Weather911::Month.create(2019, 2)
      4.times {Weather911::Day.create(month, 1)}
      Weather911::Day.delete_all
      expect(Weather911::Day.all).to eq([])
    end
  end

  describe ".valid?" do
    it "returns true if valid parameters for month" do
      month = Weather911::Month.new(2019, 2)
      expect(Weather911::Day.valid?(month, 4)).to be_truthy
    end

    it "returns false if not valid parameters for month" do
      month = Weather911::Month.new(2019, 2)
      expect(Weather911::Day.valid?(month, 30)).to be_falsey
    end
  end

end
