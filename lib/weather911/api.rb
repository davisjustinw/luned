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
    select = "SELECT date_extract_d(datetime) as day, count(*)"
    where = "WHERE date_trunc_ym(datetime) = '#{breadcrumb[0]}-#{breadcrumb[1]}-01T00:00:00.000'"
    group = "GROUP BY day ORDER BY day"
    query = URI.encode("$query=#{select} #{where} #{group}")
    parameter = "#{@seattle_url}#{query}&#{@token_parameter}"
    HTTParty.get("#{@seattle_url}#{query}").parsed_response
  end

  def get_day_ems(breadcrumb)
    select = "SELECT date_extract_hh(datetime) as hour, count(*)"
    where = "WHERE date_trunc_ymd(datetime) = '#{breadcrumb[0]}-#{breadcrumb[1]}-#{breadcrumb[2]}T00:00:00.000'"
    group = "GROUP BY hour ORDER BY hour"
    query = URI.encode("$query=#{select} #{where} #{group}")
    parameter = "#{@seattle_url}#{query}&#{@token_parameter}"
    HTTParty.get("#{@seattle_url}#{query}").parsed_response
  end

end
