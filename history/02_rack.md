!SLIDE title

# Inside Rack

!SLIDE bullets

# Rack's Structure

* Servers/Handlers
* Middleware
* Applications

!SLIDE bullets incremental

# Rack's Interface

* Call:<br/>`app.call(env)`
* Return:<br/>`[status, headers, body]`

!SLIDE bullets incremental

# What Rack Promises

* Composability
* Simple interface
* Separation of concerns

!SLIDE 

# If you like it, put a middleware on it.

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

!SLIDE bullets incremental

# Why Rack is Broken

* Blind up, Blind down
* `env` is a dumpster
* Communicate by convention (not contract)
* Middleware order matters
* High coupling
