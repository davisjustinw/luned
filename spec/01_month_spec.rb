describe "Month" do

  describe ".all" do
    it ".all includes newly created Month object" do
      obj = Luned::Month.create('1999', '12')
      expect(Luned::Month.all).to include(obj)
    end
  end

  describe "#add" do
    it "adds month to all" do
      month = Luned::Month.new(2019, 2)
      month.add
      expect(Luned::Month.all).to include(month)
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

   describe ".build" do
     it "initializes a month object and loads with dayy and calls from the api" do
       built = Luned::Month.build(2018, 2)
       binding.pry
     end
   end

   describe "#add_day" do
     it "create day object adds it to the month and returns the instance" do
       month = Luned::Month.create(2019, 2)
       day = month.add_day(1)
       expect(day).to be_an_instance_of(Luned::Day)
       expect(month.days).to include(day)
     end
   end

   describe "#minmax_count" do
     it "return the lowest and the highest count from calls" do
       month = Luned::Month.create(2019, 2)
       month.add_day(1).calls = [1,2,3,4]
       month.add_day(2).calls = [1,2]
       expect(month.minmax_count).to eq([2,4])
     end
   end

   describe ".delete_all" do
     it ".all returns an empty array after call" do
       4.times {Luned::Month.create(Date.today.year, Date.today.month)}
       Luned::Month.delete_all
       expect(Luned::Month.all).to eq([])
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
