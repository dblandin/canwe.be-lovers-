require './main.rb'
use Sass::Plugin::Rack
mime_type :jpg, 'image/jpg'
mime_type :css, 'text/css; charset=utf-8'
run Sinatra::Application