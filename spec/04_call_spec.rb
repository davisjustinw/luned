
describe "Call" do
  describe "#new" do
    it "initializes a Call object with a type and address" do
      time = Time.now
      address = "11 West Aloha"
      type = "Aid Response"
      incident_number = "1234F"

      call = Luned::Call.new(time, address, type, incident_number)
      expect(call.type).to eq(type)
      expect(call).to be_an_instance_of(Luned::Call)
    end
  end
end
