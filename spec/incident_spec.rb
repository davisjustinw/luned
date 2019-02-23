
describe "Incident" do
  describe "#new" do
    it "initializes an Incident object with a type and address" do
      type = "Aid Response"
      address = "11 West Aloha"
      incident = Weather911::Incident.new(type, address)
      expect(incident.type).to eq(type)
      expect(incident).to be_an_instance_of(Weather911::Incident)
    end
  end
end
