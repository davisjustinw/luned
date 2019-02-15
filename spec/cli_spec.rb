require "spec_helper"
require "pry"
describe "CLI" do

  describe "#valid?" do
    it "takes a string and checks against the breadcrumb array for valid input" do
      cli = Weather911::CLI.new

      cli.breadcrumb = ['2019', 'jan', '29']
      expect(cli.valid?('0900')).to be_truthy
      expect(cli.valid?('26')).to be_falsey

      cli.breadcrumb = ['2019', 'feb']
      expect(cli.valid?('30')).to be_falsey
      expect(cli.valid?('9')).to be_truthy

      cli.breadcrumb = ['2019']
      expect(cli.valid?('jan')).to be_truthy
      expect(cli.valid?('bob')).to be_falsey
      expect(cli.valid?('2')).to be_falsey

    end
  end
end
