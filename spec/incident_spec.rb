
describe "Incident" do
  describe "#new" do
    it "initializes an Incident object with a type and address" do
      time = "1330"
      address = "11 West Aloha"
      type = "Aid Response"
      incident = Weather911::Incident.new(time, address, type)
      expect(incident.type).to eq(type)
      expect(incident).to be_an_instance_of(Weather911::Incident)
    end
  end
end
