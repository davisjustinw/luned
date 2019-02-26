describe "Month" do

  describe ".all" do
    it ".all includes newly created Month object" do
      obj = Weather911::Month.create('1999', '12')
      expect(Weather911::Month.all).to include(obj)
    end
  end

  describe "#add" do
    it "adds month to all" do
      month = Weather911::Month.new(2019, 2)
      month.add
      expect(Weather911::Month.all).to include(month)
    end
  end

  describe ".create" do
     it "initializes a month object if the numeric year, month are valid" do
       expect(Weather911::Month.create('1999', '2')).to be_an_instance_of(Weather911::Month)
     end

     it "return falsey if not a valid year, month" do
       expect(Weather911::Month.create('bob', 'ross')).to be_falsey
     end

   end

   describe "#add_day" do
     it "create day object adds it to the month and returns the instance" do
       month = Weather911::Month.create(2019, 2)
       day = month.add_day(1)
       expect(day).to be_an_instance_of(Weather911::Day)
       expect(month.days).to include(day)
     end
   end

   describe "#minmax_count" do
     it "return the lowest and the highest count from calls" do
       month = Weather911::Month.create(2019, 2)
       month.add_day(1).calls = [1,2,3,4]
       month.add_day(2).calls = [1,2]
       expect(month.minmax_count).to eq([2,4])
     end
   end

   describe ".delete_all" do
     it ".all returns an empty array after call" do
       4.times {Weather911::Month.create(Date.today.year, Date.today.month)}
       Weather911::Month.delete_all
       expect(Weather911::Month.all).to eq([])
     end
   end

   describe ".valid?" do
     it "returns true if year and month make a valid month" do
       expect(Weather911::Month.valid?(2019, 2)).to be_truthy
     end

     it "returns false if year and month don't make a valid month" do
       expect(Weather911::Month.valid?('Bob', 'Ross')).to be_falsey
     end
   end

end
