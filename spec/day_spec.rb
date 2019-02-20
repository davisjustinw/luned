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

  describe "#month" do
    it "returns the three letter string name of the month" do
      obj = Weather911::Day.create('1999', '12', '1')

      expect(obj.month).to eq("Dec")
    end
  end

  describe "#year" do
    it "returns the four digit year" do
      obj = Weather911::Day.create('1999', '12', '1')

      expect(obj.year).to eq("1999")
    end
  end

  describe "#days_in_month" do
    it "returns the number of days in the month" do
      obj = Weather911::Day.new('2004', '12', '2')
      expect(obj.days_in_month).to eq(31)
    end
  end


end
