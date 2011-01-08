require 'mongoid'

if ENV['MONGOHQ_URL']
  mongo_uri = URI.parse(ENV['MONGOHQ_URL'])
  ::Mongoid.from_hash(
    "host" => mongo_uri.host,
    "port" => mongo_uri.port.to_s,
    "username" => mongo_uri.user,
    "password" => mongo_uri.password,
    "database" => mongo_uri.path.gsub('/', '')
  )
else
  ::Mongoid.from_hash(
    "host" => "localhost",
    "database" => "carto"
  )
end