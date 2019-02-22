describe "Month" do
  describe ".create" do
     it "initializes a month object if the numeric year, month are valid" do
       expect(Weather911::Month.create('1999', '2')).to be_an_instance_of(Weather911::Month)
     end

     it "return falsey if not a valid year, month" do
       expect(Weather911::Month.create('bob', 'ross')).to be_falsey
     end

     it ".get_all includes newly created Month object" do
       obj = Weather911::Month.create('1999', '12')
       expect(Weather911::Month.get_all).to include(obj)
     end
   end

   describe ".delete_all" do
     it ".get_all return an empty array after call" do
       4.times {Weather911::Month.create(Date.today.year, Date.today.month)}
       Weather911::Month.delete_all
       expect(Weather911::Month.get_all).to eq([])
     end
   end

   describe "#weekday" do
     it "returns numerical day of week (sun == 0) for the month" do
       month = Weather911::Month.new(2019, 2)

       expect(month.weekday(17)).to eq(0)
     end
   end

   describe "#month" do
     it "returns the three letter string name of the month" do
       obj = Weather911::Month.create('1999', '12')

       expect(obj.month).to eq("Dec")
     end
   end

   describe "#year" do
     it "returns the four digit year" do
       obj = Weather911::Month.create('1999', '12')

       expect(obj.year).to eq("1999")
     end
   end

   describe "#days_in_month" do
     it "returns the number of days in the month" do
       obj = Weather911::Month.new('2004', '12')
       expect(obj.days_in_month).to eq(31)
     end
   end


end
