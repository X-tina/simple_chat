require "redis"
require 'uri'

uri = URI.parse(ENV["REDISTOGO_URL"])
$redis_onlines = Redis.new(:url => uri)

$redis_likes = Redis.new(url: uri)

$redis_location = Redis.new(url: uri)
