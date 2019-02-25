require "spec_helper"
require "pry"

describe "API" do
  #DST
  #@ 3 10 0200 => 0300 -7 offset Start PDT end PST
  #to 11 3 0200 => 0100 -8 offset Start PST end PDT


  describe "#get_month" do
    it "receives array with year and month, returns an array of hashes with count and day" do
      api = Weather911::API.new
      breadcrumb = [2018, 3]
      response = api.get_month(*breadcrumb)
      binding.pry
      expect(response[3]).to eq({"count"=>"286", "day"=>"4", "weekday"=>"0"})
    end
  end

=begin
  describe "#create_month" do
    it "calls seattle api and builds a month object populated with incident counts" do
      api = Weather911::API.new
      breadcrumb = [2018, 2]
      month = api.create_month(*breadcrumb)

      expect(month).to be_an_instance_of(Weather911::Month)
      expect(month.count.first).to eq("275")
    end
  end
=end
=begin
  describe "#get_day_calls" do
    it "calls seattle 911 database and returns data in the appropriate time box" do
      api = Weather911::API.new
      day = api.get_day_calls(2018, 3, 4)
      binding.pry
      expect(day.first["incident_number"]).to eq("F180022465")
    end
  end
=end
=begin
  describe "#create_day" do
    it "creates a day, observations and calls for a date" do
      api = Weather911::API.new
      pdt = api.create_day(2018, 4, 10)
      pst = api.create_day(2018, 12, 10)
    end
  end
=end

end
