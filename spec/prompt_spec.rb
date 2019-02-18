require "spec_helper"
require "pry"

describe "Prompt" do

  describe "#display_breadcrumb" do
    it "displays prompts" do
      prompt = Weather911::Prompt.new
      expect {prompt.display_breadcrumb}.to output("<yyyy> <mm> <dd> <hr24>: ").to_stdout
    end

    it "displays prompts shortened prompt based on breadcrumb state" do
      prompt = Weather911::Prompt.new
      prompt.breadcrumb << 1999
      expect {prompt.display_breadcrumb}.to output("<mm> <dd> <hr24>: ").to_stdout
    end
  end

  describe "#valid_year?" do
    it "returns true if the string is a valid year against the 911 data" do
      prompt = Weather911::Prompt.new
      expect(prompt.valid_year?("2004")).to be_truthy
    end

    it "string returns falsey if not a valid year against the 911 data" do
      prompt = Weather911::Prompt.new
      next_year = Date.today.next_year.year
      expect(prompt.valid_year?(next_year)).to be_falsey
    end

    it "string returns falsey if not a valid year against the 911 data" do
      prompt = Weather911::Prompt.new
      expect(prompt.valid_year?("1999")).to be_falsey
    end
  end

  describe "#valid_month?" do
    it "returns true if the string is a valid month against the breadcrumb" do
      prompt = Weather911::Prompt.new
      prompt.breadcrumb = [2018]
      expect(prompt.valid_month?("12")).to be_truthy
    end

    it "returns falsey if not a valid month against breadcrumb" do
      prompt = Weather911::Prompt.new
      next_month = Date.today.next_month
      prompt.breadcrumb = []
      prompt.breadcrumb << next_month.year
      expect(prompt.valid_month?(next_month.month.to_s)).to be_falsey
    end

    it "returns falsey if not a valid month against breadcrumb" do
      prompt = Weather911::Prompt.new
      prompt.breadcrumb = [2003]
      expect(prompt.valid_month?("10")).to be_falsey
    end

  end

  describe "#valid_day?" do
    it "returns true if the string is a valid day against the breadcrumb" do
      prompt = Weather911::Prompt.new
      prompt.breadcrumb = [2010, 2]
      expect(prompt.valid_day?("12")).to be_truthy
    end

    it "takes an array and returns false if each string can't combine to make a date" do
      prompt = Weather911::Prompt.new
      prompt.breadcrumb = [2006, 2]
      expect(prompt.valid_day?("29")).to be_falsey
    end

    it "takes an array and returns false if not within 911 data" do
      prompt = Weather911::Prompt.new
      prompt.breadcrumb = [1999, 2]
      expect(prompt.valid_day?("1")).to be_falsey
    end

    it "returns falsey if not a valid day in the future against breadcrumb" do
      prompt = Weather911::Prompt.new
      next_day = Date.today.next_day
      prompt.breadcrumb = []
      prompt.breadcrumb << next_day.year
      prompt.breadcrumb << next_day.month
      expect(prompt.valid_month?(next_day.day.to_s)).to be_falsey
    end
  end

  describe "#valid_hour?" do
    it "returns true if the string is a valid hour against the breadcrumb" do
      prompt = Weather911::Prompt.new
      prompt.breadcrumb = [2010, 2, 12]
      expect(prompt.valid_hour?("12")).to be_truthy
    end

    it "takes an array and returns false if not a valid hour" do
      prompt = Weather911::Prompt.new
      prompt.breadcrumb = [2006, 2, 3]
      expect(prompt.valid_hour?("29")).to be_falsey
    end

    it "takes an array and returns false if not a valid hour in the future" do
      prompt = Weather911::Prompt.new
      now = DateTime.now
      next_hour = DateTime.new(now.year, now.month, now.day, (now.hour+1))
      prompt.breadcrumb = []
      prompt.breadcrumb << next_hour.year
      prompt.breadcrumb << next_hour.month
      prompt.breadcrumb << next_hour.day
      expect(prompt.valid_hour?(next_hour.hour.to_s)).to be_falsey
    end
  end

  describe "#before_today?" do
    it "return true if breadcrumb date is before today" do
      prompt = Weather911::Prompt.new
      prompt.breadcrumb = [2019, 01, 29]

      expect(prompt.before_today?).to be_truthy
    end

    it "return false if breadcrumb date is after today" do
      prompt = Weather911::Prompt.new
      tomorrow = Date.today.next_day
      prompt.breadcrumb = [tomorrow.year, tomorrow.month, tomorrow.day]

      expect(prompt.before_today?).to be_falsey
    end
  end

  describe "#int_from" do
    it "returns integer if string converts to valid integer" do
      prompt = Weather911::Prompt.new

      expect(prompt.int_from('2')).to eq(2)
    end

    it "return false if string doesn't convert to valid integer" do
      prompt = Weather911::Prompt.new

      expect(prompt.int_from('bob')).to be_falsey
    end
  end

  describe "#valid_input?" do
    it "takes a string and checks against the breadcrumb array for valid input" do
      prompt = Weather911::Prompt.new

      prompt.breadcrumb = [2019, 01, 29]
      expect(prompt.valid_input?('9')).to be_truthy
      expect(prompt.valid_input?('26')).to be_falsey

      prompt.breadcrumb = [2019, 02]
      expect(prompt.valid_input?('30')).to be_falsey
      expect(prompt.valid_input?('8')).to be_truthy

      prompt.breadcrumb = [2019]
      expect(prompt.valid_input?('01')).to be_truthy
      expect(prompt.valid_input?('bob')).to be_falsey
      expect(prompt.valid_input?('2')).to be_truthy
    end
  end

  describe "#up" do
    it "takes and input array and pops an entry off breadcrumb for each .." do
      prompt = Weather911::Prompt.new
      prompt.breadcrumb = [2019, 1, 29]
      input = ['..', '28']
      prompt.up(input)

      expect(prompt.breadcrumb).to eq([2019, 1])
    end

    it "takes and input array does not pop if no .. front" do
      prompt = Weather911::Prompt.new
      prompt.breadcrumb = [2019, 1, 29]
      input = ['28']
      prompt.up(input)

      expect(prompt.breadcrumb).to eq([2019, 1, 29])
    end

    it "returns a new array minus any .. at the front" do
      prompt = Weather911::Prompt.new
      prompt.breadcrumb = [2019, 1, 29]
      input = ['..', '28']
      expect(prompt.up(input)).to eq(['28'])
    end
  end

end
