require 'http'
require './lib/web_response'

# todo: write a skeleton for this to allow multiple adapters

class HttpAdapter
  def self.request_single(request)
    HttpResponse(HTTP.send(
                   request.http_method,
                   request.url,
                   brequest.content
                 ))
  end

  def self.request_several(requests)
    HTTP.persistent requests.first.host do |http|
      requests.map do |request|
        HttpResponse(http.send(
                       request.http_method,
                       request.resource,
                       request.content
                     ))
      end
    end
  end
end

class HttpResponse < WebResponse
  def initialize(http_response)
    @body = http_response.to_s
    @headers = http_response.headers
    @response_code = http_response.code
    super()
  end
end
