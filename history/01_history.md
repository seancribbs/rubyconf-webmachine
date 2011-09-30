!SLIDE title

# Ruby & HTTP
## A Selective History

!SLIDE bullets

# CGI, SCGI, FCGI

* Common Gateway Interface ('90s)
* shell/fork, setenv, exec
* standard I/O

!SLIDE

# CGI

    @@@ruby
    puts "Content-Type: text/plain"
    puts
    puts "Hello, world!"

!SLIDE

# CGI

    @@@ruby
    require 'cgi'

    cgi = CGI.new('html4')

    cgi.out {
      cgi.html {
        cgi.body { "Hello, world!" }
      }
    }

!SLIDE bullets

# WEBrick

* A standalone server
* "Servlet" interface

!SLIDE

# WEBrick

    @@@ruby
    class MyServlet < AbstractServlet
      def do_GET(request, response)
        response.status = 200
        response.body = "Hello, world!"
      end
    end

!SLIDE bullets

# Rails!

* Yay, MVC!
* Great for "web apps"!
* Made Ruby "cool"!

!SLIDE small

# Rails!

    @@@ruby
    # Routes!
    map.connect '/bar', :controller => "foo", 
                :action => "bar"
    
    # Controllers!
    class FooController < ApplicationController
      def bar
        @answer = 42
      end
    end

!SLIDE bullets

# RAILS 1.2ZOMGREST!

* A "world of resources"!
* Easy APIs! Models are URLs!
* respond_to!
* *Only* 7 actions to remember!

!SLIDE

# RAILS 1.2ZOMGREST!

    @@@ruby
    resources :widgets
    
    class WidgetsController
       def index
         @widgets = Widget.find(:all)
         respond_to do |f|
           f.xml { render :xml => @widgets }
           f.html
         end
       end  
    end

!SLIDE bullets incremental

# Two Voices in the Wilderness

* Scott Raymond - *Doing REST Right* (RailsConf '07)
* Ben Scofield - *All I Really Need to Know I Learned by Writing My
  Own Web Framework* (RubyConf '08)

!SLIDE bullets incremental

# Sinatra

* Rails too heavy, let's go raw.
* Built on Rack
* URLs + Methods = Actions

!SLIDE

# Sinatra (+ Rack)

    @@@ruby
    use Rack::ContentType, "application/json"
     
    get "/bar" do
      '{"hello":"world"}'
    end
