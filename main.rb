require 'sinatra'
require 'flickraw'
require 'imgkit'
require 'restclient'
require 'stringio'
require 'haml'
require 'sass/plugin/rack'
require 'sqlite3'
require 'sequel'

get '/css/stylesheet.css' do
  content_type :css
  scss :stylesheet
end
get '/css/card.css' do
  content_type :css
  scss :card
end
get '/css/reset.css' do
  content_type :css
  scss :reset
end

get '/' do
  redirect '/lovers?'
end

get '/lovers?' do
  haml :index
end

get '/card.jpg' do
  content_type :jpg  
  DB = Sequel.connect('sqlite://db/development.db') if ENV['RACK_ENV'] == 'development'
  DB = Sequel.connect(ENV['DATABASE_URL'] || 'postgres://localhost/mydb') if ENV['RACK_ENV'] == 'production'
  class Phrase < Sequel::Model
  end
  rand = rand(DB[:phrases].count) - 1
  @phrase = DB[:phrases][:id => rand][:phrase]
  DB.disconnect
  
  FlickRaw.api_key="38a723b3ee9b08433d2759787006fb41"
  FlickRaw.shared_secret="e96407ca6e5a507f"
  
  rand_num = rand(19) + 1
  list = flickr.groups.pools.getPhotos :group_id => '28684306@N00', :per_page => '500', :page => rand_num, :extras => 'license,owner_name', :format => 'json'
  begin
    valid = false
    photo = list[0+Random.rand(100)]
    #@owner_id      = photo["owner"]
    #@owner_name    = photo["owner_name"]
    id     = photo.id
    secret = photo.secret
    info   = flickr.photos.getInfo :photo_id => id, :secret => secret
    sizes  = flickr.photos.getSizes :photo_id => id
    large_info = sizes.find {|s| s.label == 'Large' }
    if large_info != nil
      width  = Integer(large_info.width)
      height = Integer(large_info.height)
      if width > height
        @photo_source = large_info.source
        valid = true
      end
    end
  end while valid != true
  
  url = 'http://devonblandin.com/card.css'
  css = StringIO.new( RestClient.get(url) )
  kit = IMGKit.new('<div><p>' + @phrase + '</p><img src ="' + @photo_source + '" /></div>')
  kit.stylesheets << css
  
  kit.to_jpg
end