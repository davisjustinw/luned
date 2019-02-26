require "spec_helper"
require "pry"
describe "Controller" do
  describe "#new" do
    it "initializes with a Prompt, API and View objects" do
      control = Weather911::Controller.new

      expect(control.view).to be_an_instance_of(Weather911::View)
      expect(control.api).to be_an_instance_of(Weather911::API)
      expect(control.prompt).to be_an_instance_of(Weather911::Prompt)
    end
  end




  # 2003 11 7 to today


end
