require 'mongo'
require 'mongoid'

c = Mongo::Connection.new
Mongoid.database = c['web']

class Page
	include Mongoid::Document

	field title, types: String
end
