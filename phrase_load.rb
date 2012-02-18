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
      puts line
      items.insert(:phrase => line, :created_at => Time.now)
  end
file.close