class Weather911::API

  def initialize
    if ENV['token']
      @token_parameter = "$$app_token=#{ENV['token']}"
    else
      @token_parameter = ''
    end
      @seattle_url = "https://data.seattle.gov/resource/grwu-wqtk.json?"
      @wunder_url = "https://www.wunderground.com/history/daily/us/wa/seattle-boeing/KBFI/date/2019-2-1"
  end

  def get_month(breadcrumb)
    #$select=date_trunc_ymd(datetime) as day, count(*)&$where=date between '2014-01'&$group=day
    query = URI.encode("$query=SELECT date_extract_d(datetime) as day, count(*) WHERE date_trunc_ym(datetime) = '#{breadcrumb[0]}-#{breadcrumb[1]}-01T00:00:00.000' GROUP BY day ORDER BY day")
    parameter = "#{@seattle_url}#{query}&#{@token_parameter}"
    response = HTTParty.get("#{@seattle_url}#{query}")
    puts parameter
    puts response
  end
end
