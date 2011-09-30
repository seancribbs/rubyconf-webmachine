require 'rubygems'
require 'ripple'
require 'webmachine'
require 'erb'

$LAYOUT = ERB.new(<<-CODE)
<!DOCTYPE html>
<html>
<head><title><%= @page.title %></title></head>
<body><h1><%= @page.title %></h1><%= @page.content %></body>
</html>
CODE

class Page
  include Ripple::Document
  property :title, String
  property :content, String
  timestamps! # created_at/updated_at
end

class PageResource < Webmachine::Resource
  def content_types_provided
    [["text/html", :to_html],["application/json", :to_json]]
  end
  
  def resource_exists?
    @page = Page.find(request.path_info[:slug])
    @page.present?
  end

  def to_html
    $LAYOUT.result(binding)
  end

  def to_json
    @page.attributes.to_json
  end
end

Webmachine::Dispatcher.add_route [:slug], PageResource
Webmachine::Dispatcher.add_route [], PageResource, :slug => "__root"
Webmachine.run
