require "spec_helper"
require "pry"
describe "CLI" do

  describe "#display_prompts" do
    it "displays prompts" do
      obj = Weather911::CLI.new
      expect {obj.display_prompts}.to output("<yyyy> <mm> <dd> <hr24>: ").to_stdout
    end

    it "displays prompts shortened prompt based on breadcrumb state" do
      obj = Weather911::CLI.new
      obj.breadcrumb << 1999
      expect {obj.display_prompts}.to output("<mm> <dd> <hr24>: ").to_stdout
    end
  end

  describe "#parse_input" do
    it "splits a string by ' ' and returns an array or strings" do
      expect(Weather911::CLI.new.parse_input("1999 2 12 2300")).to eq(["1999", "2", "12", "2300"])
    end
  end

  # 2003 11 7 to today
  describe "#valid_year?" do
    it "returns true if the string is a valid year against the 911 data" do
      cli = Weather911::CLI.new
      expect(cli.valid_year?("2004")).to be_truthy
    end

    it "string returns falsey if not a valid year against the 911 data" do
      cli = Weather911::CLI.new
      expect(cli.valid_year?("Bob")).to be_falsey
    end

    it "string returns falsey if not a valid year against the 911 data" do
      cli = Weather911::CLI.new
      expect(cli.valid_year?("1999")).to be_falsey
    end
  end

  describe "#valid_month?" do
    it "returns true if the string is a valid month against the breadcrumb" do
      cli = Weather911::CLI.new
      cli.breadcrumb = [2018]
      expect(cli.valid_month?("12")).to be_truthy
    end

    it "returns falsey if not a valid month against breadcrumb" do
      cli = Weather911::CLI.new
      next_month = Date.today.next_month.month.to_s
      cli.breadcrumb = [2019]
      expect(cli.valid_month?(next_month)).to be_falsey
    end

    it "returns falsey if not a valid month against breadcrumb" do
      cli = Weather911::CLI.new
      cli.breadcrumb = [2003]
      expect(cli.valid_month?("10")).to be_falsey
    end

  end

  describe "#valid_day?" do
    it "returns true if the string is a valid day against the breadcrumb" do
      cli = Weather911::CLI.new
      cli.breadcrumb = [2010, 2]
      expect(cli.valid_day?("12")).to be_truthy
    end

    it "takes an array and returns false if each string can't combine to make a date" do
      cli = Weather911::CLI.new
      cli.breadcrumb = [2006, 2]
      expect(cli.valid_day?("29")).to be_falsey
    end

    it "takes an array and returns false if not within 911 data" do
      cli = Weather911::CLI.new
      cli.breadcrumb = [1999, 2]
      expect(cli.valid_day?("1")).to be_falsey
    end
  end

  describe "#valid_input?" do
    it "takes a string and checks against the breadcrumb array for valid input" do
      cli = Weather911::CLI.new

      cli.breadcrumb = [2019, 01, 29]
      expect(cli.valid_input?('09')).to be_truthy
      expect(cli.valid_input?('26')).to be_falsey

      cli.breadcrumb = ['2019', '02']
      expect(cli.valid_input?('30')).to be_falsey
      expect(cli.valid_input?('9')).to be_truthy

      cli.breadcrumb = ['2019']
      expect(cli.valid_input?('01')).to be_truthy
      expect(cli.valid_input?('bob')).to be_falsey
      expect(cli.valid_input?('2')).to be_falsey
    end
  end



end
