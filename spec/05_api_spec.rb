require "spec_helper"
require "pry"

describe "API" do
  #DST
  #@ 3 10 0200 => 0300 -7 offset Start PDT end PST
  #to 11 3 0200 => 0100 -8 offset Start PST end PDT

=begin
  describe "#get_calls" do
    it "receives array with year and month, returns an array of hashes with count and day" do
      api = Weather911::API.new
      breadcrumb = [2018, 3]
      response = api.get_calls(*breadcrumb)
      binding.pry
      expect(response[0]["incident_number"]).to eq({"F180021327"})
      expect(response[-1]["incident_number"]).to eq({"F180032527"})
    end
  end

  describe "#create_calls" do
    it "receives array with year and month, returns an array of hashes with count and day" do
      api = Weather911::API.new
      breadcrumb = [2018, 3]
      response = api.create_calls(*breadcrumb)

    end
  end

  describe "#create_observations" do
    it "creates a day, observations and calls for a date" do
      api = Weather911::API.new
      pdt = api.create_observations(2018, 4, 10)
      pst = api.create_observations(2018, 12, 10)

    end
  end
=end
end
