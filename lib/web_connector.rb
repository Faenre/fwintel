require './lib/external/http_gem_interface'

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
