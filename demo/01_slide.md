!SLIDE

# Now let's build something! #

!SLIDE

# Goal: An app that takes markers from a database and plots them on a map #

!SLIDE commandline incremental

# Getting started

    $ mkdir ~/carto
    $ cd ~/carto

!SLIDE commandline incremental

# Initialising git and heroku

    $ git init
    Initialized empty Git repository in /Users/tomw/carto/.git/
    
    $ heroku create
    Creating cold-summer-783..... done
    Created http://cold-summer-783.heroku.com/ | git@heroku.com:cold-summer-783.git
    Git remote heroku added

!SLIDE

## Gemfile ##

    @@@ ruby
    source :rubygems
    
    gem 'sinatra'
    gem 'bson_ext', '1.0.9'
    gem 'mongoid', '2.0.0.beta.20'
    
!SLIDE commandline incremental

# Install our gems #

    $ bundle install
    Fetching source index for http://rubygems.org/
    Using activesupport (3.0.3) 
    Using builder (2.1.2) 
    Using i18n (0.5.0) 
    .............
    Using sinatra (1.1.2) 
    Using bundler (1.0.7) 
    Your bundle is complete! Use `bundle show [gemname]` to see where a bundled gem is installed.
    
!SLIDE 

## config.ru ##

    @@@ ruby
    require 'sinatra'
    require 'erb'
    
    get '/' do
      @message = "Hello From Sinatra"
      erb :index
    end

    run Sinatra::Application

!SLIDE
    
## views/index.erb ##

    @@@ html
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Hello World</title>
        </head>
        <body>
            <h1><%= @message %></h1>
        </body>
    </html>
    
!SLIDE commandline incremental

## Start the server
    
    $ rackup
    [2011-01-07 10:14:27] INFO  WEBrick 1.3.1
    [2011-01-07 10:14:27] INFO  ruby 1.8.7 (2010-04-19) [i686-darwin10.4.0]
    [2011-01-07 10:14:27] INFO  WEBrick::HTTPServer#start: pid=23931 port=9292

!SLIDE

# Now I can visit <a href="http://localhost:9292/">http://localhost:9292/</a>

!SLIDE commandline incremental

## Add the files to git

    $ git add --all
    $ git commit -m "Initial commit"
    [master (root-commit) 478de42] Initial commit
    4 files changed, 57 insertions(+), 0 deletions(-)
    create mode 100644 Gemfile
    create mode 100644 Gemfile.lock
    create mode 100644 config.ru
    create mode 100644 views/index.erb

!SLIDE commandline incremental

## Deploy the app to heroku

    $ git push heroku master
    Counting objects: 7, done.
    Delta compression using up to 2 threads.
    Compressing objects: 100% (6/6), done.
    Writing objects: 100% (7/7), 994 bytes, done.
    Total 7 (delta 0), reused 0 (delta 0)

    -----> Heroku receiving push
    -----> Sinatra app detected
    -----> Gemfile detected, running Bundler version 1.0.3
           Unresolved dependencies detected; Installing...
           Compiled slug size is 8.7MB
    -----> Launching... done
           http://cold-summer-783.heroku.com deployed to Heroku

!SLIDE commandline incremental
           
## The app is now live on the internet!
    
    $ heroku open
    
!SLIDE commandline incremental

## Adding a database

    $ heroku addons:add mongohq:free

!SLIDE
    
## mongoid_config.rb

    @@@ ruby
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

!SLIDE

## Add a model to config.ru

    @@@ ruby
    require 'mongoid_config'

    class Marker
      include Mongoid::Document
    end
    
!SLIDE

## Add two more actions to config.ru

    @@@ ruby
    
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

!SLIDE
    
## Finally, change views/index.erb

    @@@ html
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        </head>
        <body>
            <form action="/markers" method="post">
              Name: <input name="name" type="text"/>
              Lat: <input name="lat" type="text"/>
              Lng: <input name="lng" type="text"/>
              <input type="submit">
            </form>
        </body>
    </html>

!SLIDE

## And add views/show.erb

    @@@ html
    <h1><%= @marker.name %></h1>
    <image!!! src="http://maps.google.com/maps/api/staticmap?size=512x512&maptype=roadmap&markers=color:blue|<%= @marker.lat %>,<%= @marker.lng %>&sensor=false"/>

    <p>
    <a href="/">Add another</a>
    </p>

!SLIDE commandline incremental

## Finally redeploy our app

    $ git add --all
    $ git commit -m "Version 2"
    $ git push heroku master
    -----> Heroku receiving push
    -----> Sinatra app detected
    -----> Gemfile detected, running Bundler version 1.0.3
           Compiled slug size is 8.7MB
    -----> Launching... done
           http://cold-summer-783.heroku.com deployed to Heroku

!SLIDE commandline

## And try it out...

    $ heroku open

!SLIDE

## Let's enter lat/lng: 51.434374,-0.521164

!SLIDE bullets incremental

# Conclusion

* Ruby makes writing web applications easy
* Heroku makes deploying these apps simple

!SLIDE bullets incremental

# One more thing...

* Heroku has a downside - it's expensive
* I'll leave that as a problem for Salesforce to solve!

!SLIDE

# Thanks for your time

