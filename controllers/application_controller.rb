require 'sinatra/base'
require 'sinatra/json'

class ApplicationController < Sinatra::Base

  set :root, File.join(File.dirname(__FILE__), '..')

  set :faye_client, Faye::Client.new("http://localhost:9292/faye")

  routes_missing = lambda do
    json :response => "Cette route n'existe pas"
  end

  get '*', &routes_missing

end
