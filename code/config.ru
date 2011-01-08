require 'sinatra'
require 'erb'

require 'mongoid_config'

class Marker
  include Mongoid::Document
end

get '/' do
  @message = "Hello From Sinatra"
  erb :index
end

post '/markers' do
  marker = Marker.create!(
    :name => params['name'], 
    :lng => params['lng'], 
    :lat => params['lat']
  )
  redirect '/markers/' + marker.id.to_s
end

get '/markers/:id' do
  @marker = Marker.find(params['id'])
  erb :show
end

run Sinatra::Application