require ./main.rb
use Sass::Plugin::Rack
mime_type :jpg, 'image/jpg'
mime_type :css, 'text/css; charset=utf-8'
config.wkhtmltoimage = Rails.root.join('bin', 'wkhtmltoimage-amd64').to_s if ENV['RACK_ENV'] == 'production'
run Sinatra::Application
