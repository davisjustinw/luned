#require "spec_helper"
describe "Day" do


 describe ".create" do
    it "initializes a day object if the numeric year, month and day are valid" do
      expect(Weather911::Day.create('1999', '2', '13')).to be_an_instance_of(Weather911::Day)
    end

    it "return falsey if not a valid year, month and day" do
      expect(Weather911::Day.create('bob', 'ross', 'artist')).to be_falsey
    end

    it ".get_all includes newly created Day object" do
      obj = Weather911::Day.create('1999', '12', '1')
      expect(Weather911::Day.get_all).to include(obj)
    end
  end

  describe ".delete_all" do
    it ".get_all return an empty array after call" do
      4.times {Weather911::Day.create(Date.today.year, Date.today.month, Date.today.day)}
      Weather911::Day.delete_all
      expect(Weather911::Day.get_all).to eq([])
    end
  end

  api = Weather911::API.new
  #day = api.create_day(2018, 3, 4)
  day = api.get_day_calls(2018, 3, 4)
  
  describe "observations" do
    it "returns array of Observations for the month" do

      expect(day.observations.size).to eq(24)
    end
  end

  describe "calls" do
    it "returns array of Calls for the month" do
      calls = day.calls

      binding.pry
    end
  end

end
