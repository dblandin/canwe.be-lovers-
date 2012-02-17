#require 'data_mapper'
#require 'dm-sqlite-adapter'

#DataMapper.setup( :default, "sqlite3://#{Dir.pwd}/db/development.db" )

#class Phrase
#  include DataMapper::Resource

#  property :id,         Serial    # An auto-increment integer key
#  property :phrase,     String, :required => true    # A varchar type string, for short strings
#end
#DataMapper.finalize
#DataMapper.auto_migrate!
#DataMapper::Property.auto_validation(false)
require "sequel"

DB = Sequel.connect('sqlite://db/development.db')

DB.create_table :phrases do
  primary_key :id
  String :phrase
  DateTime :created_at
end

items = DB[:phrases]

file = File.open('phrases.txt')
  while line = file.gets
    # if ( line =~ /^(.+) \((\d\d\d\d).*\)/ )
    if ( line =~ /^(.+)(?:\/)(.+)(?:\/)(.+)$/ )
      puts line
      items.insert(:phrase => $3, :created_at => Time.now)
    end
  end
file.close