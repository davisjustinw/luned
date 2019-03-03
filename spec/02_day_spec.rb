#require "spec_helper"
describe "Day" do

 describe ".create" do
    it "initializes a day object if the numeric year, month and day are valid" do
      month = Luned::Month.new(1999, 2)
      expect(Luned::Day.create(month, '13')).to be_an_instance_of(Luned::Day)
    end

    it "return falsey if not a valid year, month and day" do
      month = Luned::Month.new(1999, 2)
      expect(Luned::Day.create(month, 31)).to be_falsey
    end

    it ".all includes newly created Day object" do
      month = Luned::Month.new(1999, 2)
      obj = Luned::Day.create(month, '1')
      expect(Luned::Day.all[obj.time]).to eq(obj)
    end
  end

  describe "#add" do
    it "adds Day to all" do
      month = Luned::Month.new(2019, 2)
      day = Luned::Day.new(month, 3)
      day.add
      expect(Luned::Day.all[day.time]).to eq(day)
    end
  end

  describe "#build_observations" do
    it "fills out the Days hour objects with observation objects filled wil dark sky data" do
      month = Luned::Month.new(2019, 2)
      day = Luned::Day.new(month, 3)
      day.build_observations
      expect(day.hours[day.hours.keys.sample].observation).to be_truthy
      expect(day.summary).not_to be_empty
      expect(day.hours.size).to be(24)
    end
  end

  describe "#count" do
    it "returns number of calls associated with the day" do
      #need to fix
      month = Luned::Month.create(2019, 2)
      day = Luned::Day.new(month, 1)
      day.calls = [1,2,3,4]
      expect(day.count).to eq(4)
    end
  end

  describe ".delete_all" do
    it ".all return an empty array after call" do
      month = Luned::Month.create(2019, 2)
      4.times {Luned::Day.create(month, 1)}
      Luned::Day.delete_all
      expect(Luned::Day.all).to eq({})
    end
  end

  describe ".valid?" do
    it "returns true if valid parameters for month" do
      month = Luned::Month.new(2019, 2)
      expect(Luned::Day.valid?(month, 4)).to be_truthy
    end

    it "returns false if not valid parameters for month" do
      month = Luned::Month.new(2019, 2)
      expect(Luned::Day.valid?(month, 30)).to be_falsey
    end
  end

end
