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
      next_year = Date.today.next_year.year
      expect(cli.valid_year?(next_year)).to be_falsey
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
      next_month = Date.today.next_month
      cli.breadcrumb = []
      cli.breadcrumb << next_month.year
      expect(cli.valid_month?(next_month.month.to_s)).to be_falsey
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

    it "returns falsey if not a valid day in the future against breadcrumb" do
      cli = Weather911::CLI.new
      next_day = Date.today.next_day
      cli.breadcrumb = []
      cli.breadcrumb << next_day.year
      cli.breadcrumb << next_day.month
      expect(cli.valid_month?(next_day.day.to_s)).to be_falsey
    end
  end

  describe "#valid_hour?" do
    it "returns true if the string is a valid hour against the breadcrumb" do
      cli = Weather911::CLI.new
      cli.breadcrumb = [2010, 2, 12]
      expect(cli.valid_hour?("12")).to be_truthy
    end

    it "takes an array and returns false if not a valid hour" do
      cli = Weather911::CLI.new
      cli.breadcrumb = [2006, 2, 3]
      expect(cli.valid_hour?("29")).to be_falsey
    end

    it "takes an array and returns false if not a valid hour in the future" do
      cli = Weather911::CLI.new
      now = DateTime.now
      next_hour = DateTime.new(now.year, now.month, now.day, (now.hour+1))
      cli.breadcrumb = []
      cli.breadcrumb << next_hour.year
      cli.breadcrumb << next_hour.month
      cli.breadcrumb << next_hour.day
      expect(cli.valid_hour?(next_hour.hour.to_s)).to be_falsey
    end
  end

  describe "#valid_input?" do
    it "takes a string and checks against the breadcrumb array for valid input" do
      cli = Weather911::CLI.new

      cli.breadcrumb = [2019, 01, 29]
      expect(cli.valid_input?('09')).to be_truthy
      expect(cli.valid_input?('26')).to be_falsey

      cli.breadcrumb = [2019, 02]
      expect(cli.valid_input?('30')).to be_falsey
      expect(cli.valid_input?('9')).to be_truthy

      cli.breadcrumb = [2019]
      expect(cli.valid_input?('01')).to be_truthy
      expect(cli.valid_input?('bob')).to be_falsey
      expect(cli.valid_input?('2')).to be_falsey
    end
  end

  describe "#up" do
    it "takes and input array and pops an entry off breadcrumb for each .." do
      cli = Weather911::CLI.new
      cli.breadcrumb = [2019, 1, 29]
      input = ['..', '28']
      cli.up(input)

      expect(cli.breadcrumb).to eq([2019, 1])
    end

    it "takes and input array does not pop if no .. front" do
      cli = Weather911::CLI.new
      cli.breadcrumb = [2019, 1, 29]
      input = ['28']
      cli.up(input)

      expect(cli.breadcrumb).to eq([2019, 1, 29])
    end

    it "returns a new array minus any .. at the front" do
      cli = Weather911::CLI.new
      cli.breadcrumb = [2019, 1, 29]
      input = ['..', '28']
      expect(cli.up(input)).to eq(['28'])
    end
  end

end
