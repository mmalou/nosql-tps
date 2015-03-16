require 'redis'
require 'json'
require 'mongo'
require 'open-uri'
require 'nokogiri'

$r = Redis.new

:task
:url

#r.del(jobsUnDo)

class Job
	def initialize(task,url)
		@task=task
		@url=url
	end

	def task
		@task
	end

	def url
		@url
	end

	def toJson
		{task: @task, url: @url}.to_json
	end
end

def addJob(job)
	$r.rpush('jobsUnDo',job.toJson)
end

job1 = Job.new('GET','http://www.google.com')
addJob(job1)

myParse=JSON.parse($r.rpop("jobsUnDo"));
doc = Nokogiri::HTML(open(myParse["url"])) do |config|
  config.strict.nonet
end

puts doc.css()