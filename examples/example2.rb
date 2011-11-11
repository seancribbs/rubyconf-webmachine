require 'rubygems'
require 'webmachine'
require 'erb'

$LAYOUT = ERB.new(<<-CODE)
<!DOCTYPE html>
<html>
<head><title><%= @page.title %></title></head>
<body><h1><%= @page.title %></h1><%= @page.content %></body>
</html>
CODE

Page = Struct.new(:title, :content)

class PageResource < Webmachine::Resource
  def resource_exists?
    @page = Page.new("My Website", "Hello, world!")
    true
  end
  
  def to_html
    $LAYOUT.result(binding)
  end
end

Webmachine.routes do
  add [], PageResource
end.run
