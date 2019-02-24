
describe "Call" do
  describe "#new" do
    it "initializes an Call object with a type and address" do
      time = "1330"
      address = "11 West Aloha"
      type = "Aid Response"
      call = Weather911::Call.new(time, address, type)
      expect(call.type).to eq(type)
      expect(call).to be_an_instance_of(Weather911::Call)
    end
  end
end
