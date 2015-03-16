require 'redis'
require 'mongo'
require 'json'
require 'open-uri'
require 'nokogiri'

$r = Redis.new

class ToMongo
	myParse=JSON.parse($r.rpop("jobsUnDo"));
	doc = Nokogiri::HTML(open(myParse["url"])) do |config|
	  config.strict.nonet
	end

	puts doc.css("title") #put in mongodb here later
	
end



