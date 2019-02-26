
describe "Call" do
  describe "#new" do
    it "initializes a Call object with a type and address" do
      time = "1330"
      address = "11 West Aloha"
      type = "Aid Response"
      incident_number = "1234F"
      month = Weather911::Month.create(2019, 2)
      day = Weather911::Day.new(month, 1)
      call = Weather911::Call.new(day, time, address, type, incident_number)
      expect(call.type).to eq(type)
      expect(call).to be_an_instance_of(Weather911::Call)
    end
  end
end
