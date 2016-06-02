require "redis"
require 'uri'

uri = URI.parse(ENV["REDISTOGO_URL"])
$redis_onlines = Redis.new(:url => uri)
