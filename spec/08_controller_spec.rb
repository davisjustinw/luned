
describe "Controller" do
  describe "#new" do
    it "initializes with a Prompt and View objects" do
      control = Luned::Controller.new

      expect(control.view).to be_an_instance_of(Luned::View)
      expect(control.prompt).to be_an_instance_of(Luned::Prompt)
    end
  end

end
