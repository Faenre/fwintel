# Describes the request structure
class WebRequest
  attr_reader :http_method, :host, :resource, :content

  def initialize(http_method, host, resource, **content)
    @http_method = http_method
    @host = host
    @resource = resource
    @content = content
  end

  def url
    @host + @resource
  end
end
