require 'open-uri'
require 'zlib'
require 'yajl'
require 'mongo'
require 'pp'

db = Mongo::Connection.new()['github']

(0...24).each do |hour|

	gz = open(URI.encode("http://data.githubarchive.org/2015-01-02-#{hour}.json.gz"))
	js = Zlib::GzipReader.new(gz).read

	Yajl::Parser.parse(js) do |event|
		event['created_at'] = Time.parse(event['created_at'])
		db['oneday'] << event
	end
end



pp db['oneday'].aggregate([
	{:$match:{:status=>""}},
	{:$group=>{:_id=>{hour:{:$hour=>"$created_at"}, type:'$type'}, :count=>{:$sum=>1}}},
	{:$sort=>{"_id.hour"=>1, "_id.type"=>1}}
])

pp db['oneday'].aggregate([
	{:$group=>{:_id=>{:hour=>{:$hour=>"$created_at"}, user:'$actor.id'}, :count=>{:$sum=>1}}},
	{:$sort=>{:count=>-1}},
	{:$limit=>5}
])
