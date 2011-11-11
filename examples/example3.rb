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
  def resource_exists?
    @page = Page.find(request.path_info[:slug])
    @page.present?
  end

  def to_html
    $LAYOUT.result(binding)
  end
end

Webmachine.routes do
  add [:slug], PageResource
  add [], PageResource, :slug => "__root"
end.run
