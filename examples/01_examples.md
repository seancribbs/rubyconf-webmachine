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
    Webmachine.routes do
      add [], PageResource
    end.run

#### 1 (web)
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

#### 2 (web)
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

    Webmachine.routes do
      add [:slug], PageResource
      add [], PageResource, :slug => "__root"
    end.run

#### 3 (web)

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

#### 4 (web/httpc)

!SLIDE small

# Conditional Requests

    @@@ruby
    require 'digest/md5'
    
    def last_modified
      @page.updated_at
    end

    def generate_etag
      Digest::MD5.hexdigest(@page.title + 
                              @page.content)
    end

#### 5 (httpc)

!SLIDE smaller

# Create/update pages

    @@@ruby
    def allowed_methods
      %W[GET HEAD PUT]
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

#### 6 (httpc)

!SLIDE smaller

# Authenticate PUTs

    @@@ruby
    include Webmachine::Resource::Authentication
    
    def is_authorized?(auth)
      request.method != 'PUT' ||
        basic_auth(auth) do |user,password|
          user == 'sean' && password == 'password'
        end
    end

#### 7 (httpc)
