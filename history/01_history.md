!SLIDE title

# Ruby & HTTP
## A Short History

!SLIDE

# CGI

    @@@ruby
    puts "Content-Type: text/plain"
    puts
    puts "Hello, world!"

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

![ZOMGREST! Now I can respond_to all my friends!](railsgirl.jpg)

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

!SLIDE

# Sinatra (+ Rack)

    @@@ruby
    use Rack::ContentType, "application/json"
     
    get "/bar" do
      '{"hello":"world"}'
    end

!SLIDE 

# Rack: If you like it, put a middleware on it.

![Beyonce](beyonce.jpg)

!SLIDE small

# Middleware

    @@@ruby
    class BroWare
      def initialize(app)
        @app = app
      end
      
      def call(env)
        status, headers, body = @app.call(env)
        [
         status, 
         headers.merge('X-Hey-Bro' => 'cool story'), 
         body
        ]
      end
    end

!SLIDE

![cool story bro](coolstory.jpg)
