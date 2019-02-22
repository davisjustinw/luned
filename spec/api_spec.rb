require "spec_helper"
require "pry"

describe "API" do
  describe "#get_month" do
    it "receives array with year and month, returns an array of hashes with count and day" do
      api = Weather911::API.new
      breadcrumb = [2019, 2]
      response = api.get_month(breadcrumb)

      expect(response[0]).to eq({"count"=>"323", "day"=>"1"})
    end
  end

  describe "#get_day_ems" do
    it "receives array with y,m,d returns array of hashes with count and hour" do
      api = Weather911::API.new
      breadcrumb = [2019, 2, 1]
      response = api.get_day_ems(breadcrumb)

      expect(response[0]).to eq({"count"=>"9", "hour"=>"0"})
    end
  end

  describe "#get_hour_ems" do
    it "receives array with y,m,d,h returns array of " do
      api = Weather911::API.new
      breadcrumb = [2019, 2, 1, 0]
      response = api.get_hour_ems(breadcrumb)

      expect(response[0]).to eq({"address"=>"14th Av / E Alder St", "datetime"=>"2019-02-01T00:02:00.000", "type"=>"Aid Response"})
    end
  end

end
