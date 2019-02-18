#environment file
require "open-uri"
require "nokogiri"
require "pry"
require "httparty"
require "soda/client"
require "date"

require_relative "weather911/version"
require_relative "weather911/cli"
require_relative "weather911/scraper"
require_relative "weather911/day"
require_relative "weather911/prompt" 
