require 'rubygems'
require 'webmachine'

class PageResource < Webmachine::Resource
  def to_html
    "<html><body>My Website</body></html>"
  end
end

Webmachine.routes do
  add [], PageResource
end.run
