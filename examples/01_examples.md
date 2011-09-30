!SLIDE title

# Webmachine Example
## A Simple "CMS"

!SLIDE small

# Create a Basic Resource

    @@@ruby
    require 'webmachine'

    class PageResource < Webmachine::Resource
      def to_html
        "<html><body>My Website</body></html>"
      end
    end

!SLIDE small

# Map URI to Resource

    @@@ruby
    Webmachine::Dispatcher.add_route [], PageResource
    Webmachine.run

!SLIDE smaller

# Create a layout

    @@@ruby
    require 'erb'

    $LAYOUT = ERB.new(<<-CODE)
    <!DOCTYPE html>
    <html>
    <head><title><%= @page.title %></title></head>
    <body><h1><%= @page.title %></h1><%= @page.content %></body>
    </html>
    CODE

!SLIDE small

# Render the layout

    @@@ruby
    Page = Struct.new(:title, :content)

    # Inside the resource
    def resource_exists?
      @page = Page.new("My Website", "Hello, world!")
      true
    end

    def to_html
      $LAYOUT.result(binding)
    end

!SLIDE small

# Add a real model

    @@@ruby
    require 'ripple'

    class Page
      include Ripple::Document
      property :title, String
      property :content, String
      timestamps! # created/updated_at
    end

!SLIDE smaller

# Find the model to be rendered

    @@@ruby
    def resource_exists?
      @page = Page.find(request.path_info[:slug])
      @page.present?
    end

    Webmachine::Dispatcher.add_route [:slug], PageResource
    Webmachine::Dispatcher.add_route [], PageResource, 
            :slug => "__root"

!SLIDE small

# Add another representation

    @@@ruby
    def content_types_provided
      [["text/html", :to_html],
       ["application/json", :to_json]]
    end

    def to_json
      @page.attributes.to_json
    end

!SLIDE small

# Conditional Requests

    @@@ruby
    def last_modified
      @page.updated_at
    end

    def generate_etag
      @page.robject.etag
    end

!SLIDE smaller

# Create/update pages

    @@@ruby
    def allowed_methods
      %W[GET HEAD PUT OPTIONS]
    end

    def content_types_accepted
      [["application/json", :store_page]]
    end

    def store_page
      @page ||= Page.new.tap do |p|
        p.key = request.path_info[:slug]
      end
      attrs = JSON.parse(request.body.to_s)
      @page.update_attributes(attrs)
    end

!SLIDE smaller

# Authenticate PUTs

    @@@ruby
    def is_authorized?(auth)
      request.method != 'PUT' ||
        (auth =~ /^Basic (.*)$/i && check_basic_password($1)) ||
        'Basic realm="Webmachine"'
    end

    private
    def check_basic_password(creds)
      creds.unpack('m*').first.split(':', 2) == 
        %W[sean password]
    end
