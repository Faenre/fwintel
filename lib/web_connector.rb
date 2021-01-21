require "./lib/external/#{ENV['HTTP_ADAPTER'] || 'httpgem'}"

# Passes requests into the correct adapter module.
class WebConnector
  def self.single(request)
    HttpAdapter.request_single(request)
  end

  def initialize(requests = nil)
    @queue = requests || []
  end

  def enqueue(request)
    @queue.append(request)
  end

  def retrieve_request_responses
    HTTPAdapter.request_several(@queue)
  end
end

# Describes the request structure
class Request
  attr_reader :http_method, :host, :resource, :contents

  def initialize(http_method, host, resource, **content)
    @http_method = http_method
    @host = host
    @resource = resource
    @contents = content
  end

  def url
    @host + @resource
  end
end
