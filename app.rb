require 'pp'
require 'bundler'
Bundler.require
require 'yaml'

class App < Sinatra::Base

  (
   Dir['./models/*.rb'].sort +
   Dir['./helpers/*.rb'].sort
  ).uniq.each { |rb| require rb }

  enable   :raise_errors, :logging
  enable   :show_exceptions  if development?
  set      :root, File.dirname(__FILE__)

  register Sinatra::Contrib
  register Sinatra::CompassSupport
  register Sinatra::AssetPack
  register Mustache::Sinatra

  helpers  Sinatra::Partials

  configure :development do |config|
    require "sinatra/reloader"
    register Sinatra::Reloader
    config.also_reload "models/*.rb"
    require_dependency "models/item.rb" # workaround lazy loading of classes in development
  end

  configure do
    env = ENV["RACK_ENV"] || "development"
    database  = YAML::load_file("db/config.yml")
    ActiveRecord::Base.establish_connection(database[env])
    ActiveRecord::Base.include_root_in_json = false
    ActiveRecord::Base.inheritance_column = 'kind'
  end

  assets {
    js :head, [
      '/js/modernizr.js'
    ]
    js :main, [
      '/js/jquery.js',
      '/js/underscore.js',
      '/js/backbone.js',
      '/js/icanhaz.js',
      '/js/application.js',
    ]
    css :main, [
      '/css/*.css'
    ]
  }

  get '/' do
    @todos = Item.all
    haml :index
  end

  get "/favicon.ico" do
    ""
  end

  get '/api/todos' do
    Item.all.to_json
  end

  get '/api/todos/:id' do
    Item.find(params[:id]).to_json
  end

  post '/api/todos' do
    Item.create(JSON.parse(request.body.read))
  end

  delete '/api/todos/:id' do
    Item.destroy(params[:id])
  end

  put '/api/todos/:id' do
    item = Item.find(params[:id])
    item.update_attributes(JSON.parse(request.body.read))
  end

end

