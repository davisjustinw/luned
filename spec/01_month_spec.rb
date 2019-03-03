describe "Month" do

  describe ".all" do
    it "includes newly created Month object" do
      obj = Luned::Month.create(1999, 12)
      expect(Luned::Month.all[obj.time]).to eq(obj)
    end
  end

  describe "#add" do
    it "adds month to all" do
      month = Luned::Month.create(2019, 2)
      month.add
      expect(Luned::Month.all[month.time]).to eq(month)
    end
  end

  describe ".create" do
     it "initializes a month object if the numeric year, month are valid" do
       expect(Luned::Month.create('1999', '2')).to be_an_instance_of(Luned::Month)
     end

     it "return falsey if not a valid year, month" do
       expect(Luned::Month.create('bob', 'ross')).to be_falsey
     end
   end

   describe ".build_from_api" do
     it "initializes a month object and loads with day and calls from the api" do
       built = Luned::Month.build_from_api(2018, 2)
       expect(built).to be_an_instance_of(Luned::Month)
       expect(built.days.keys).to be_truthy
       expect(built.count_calls).to be > 0
     end
   end

   describe "#new_day" do
     it "create day object adds it to the month and returns the instance" do
       month = Luned::Month.create(2019, 2)
       day = month.new_day(1)
       expect(day).to be_an_instance_of(Luned::Day)
       expect(month.days[day.time.day]).to eq(day)
     end
   end

   describe "#minmax_count" do
     it "return the lowest and the highest count from calls" do
       month = Luned::Month.build_from_api(2019, 2)
       expect(month.minmax_count).to eq([223,353])
     end
   end

   describe ".valid?" do
     it "returns true if year and month make a valid month" do
       expect(Luned::Month.valid?(2019, 2)).to be_truthy
     end

     it "returns false if year and month don't make a valid month" do
       expect(Luned::Month.valid?('Bob', 'Ross')).to be_falsey
     end
   end

end
