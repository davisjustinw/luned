
describe "Call" do
  describe "#new" do
    it "initializes a Call object with a type and address" do
      time = "1330"
      address = "11 West Aloha"
      type = "Aid Response"
      incident_number = "1234F"
      month = Luned::Month.create(2019, 2)
      day = Luned::Day.new(month, 1)
      call = Luned::Call.new(day, time, address, type, incident_number)
      expect(call.type).to eq(type)
      expect(call).to be_an_instance_of(Luned::Call)
    end
  end
end
