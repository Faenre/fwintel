require 'bundler/setup'

require 'simplecov'
SimpleCov.start
require 'minitest/autorun'

require './lib/web_response'

class WebResponseTest < MiniTest::Test
  def setup
    @response = WebResponse.new
  end

  def test_has_date_after_initialization
    assert_instance_of DateTime, @response.time
  end

  def test_20x_response_codes_ok
    @response.response_code = 200
    assert @response.ok?
    @response.response_code = 203
    assert @response.ok?
  end

  def test_30x_response_codes_ok
    @response.response_code = 300
    assert @response.ok?
    @response.response_code = 302
    assert @response.ok?
  end

  def test_10x_response_codes_ok
    @response.response_code = 300
    assert @response.ok?
    @response.response_code = 302
    assert @response.ok?
  end

  def test_40x_response_codes_not_ok
    @response.response_code = 401
    refute @response.ok?
    @response.response_code = 404
    refute @response.ok?
  end

  def test_50x_response_codes_not_ok
    @response.response_code = 502
    refute @response.ok?
    @response.response_code = 503
    refute @response.ok?
  end
end
