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
    api = Weather911::API.new
    breadcrumb = [2019, 2, 1]
    response = api.get_day_ems(breadcrumb)

    expect(response[0]).to eq({"count"=>"323", "day"=>"1"})
  end
end
