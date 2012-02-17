require './main.rb'
IMGKit.configure do |config|
  config.wkhtmltoimage = File.join('bin', 'wkhtmltoimage-amd64').to_s if ENV['RACK_ENV'] == 'production'
end
use Sass::Plugin::Rack
mime_type :jpg, 'image/jpg'
mime_type :css, 'text/css; charset=utf-8'
run Sinatra::Application