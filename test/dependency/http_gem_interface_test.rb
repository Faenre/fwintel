require 'bundler/setup'

require 'simplecov'
SimpleCov.start
require 'minitest/autorun'

require './lib/web_request'
require './lib/web_response'
require './lib/external/http_gem_interface'

class HTTPGemAdapterTest < Minitest::Test
  EXAMPLE_URL = 'http://example.org'
  EXAMPLE_REQUEST = [:get, EXAMPLE_URL, '/']
  EXAMPLE_CONTENT = "<a href=\"https://www.iana.org/domains/example\">\
More information...</a>"

  def setup
    @request = WebRequest.new(*EXAMPLE_REQUEST)
    @response = HttpAdapter.request_single(@request)
  end

  def test_returns_httpresponse_object
    assert_instance_of HttpResponse, @response
    assert_kind_of WebResponse, @response
  end

  def test_makes_successful_request
    assert_includes @response.body, EXAMPLE_CONTENT
  end

  def test_makes_several_requests
    requests = 3.times.map { @request }
    responses = HttpAdapter.request_several(requests)

    assert_instance_of Array, responses
    assert responses.all?(WebResponse)
  end
end
