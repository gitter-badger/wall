require 'sinatra'
require 'json'
require 'mongoid'
require 'faye'

require_relative 'controllers/application_controller'

set :port, 9292

Dir.glob('./{models,controllers}/*.rb').each { |file| require file }

Mongoid.load!("config/mongoid.yml")


Faye::WebSocket.load_adapter 'thin'
use Faye::RackAdapter, mount: '/faye', timeout: 45, extensions: []
map('/catcher') {run CatcherController}
map('/display') {run DisplayController}
map('/') {run PanelController}

