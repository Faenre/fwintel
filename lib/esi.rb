require 'date'
require 'http'

# Wrapper object for HTTP gem
class ESIHandler
  ALLOWED_METHODS = %w[get post put delete].freeze
  ESI = 'https://esi.evetech.net/latest/%s'

  attr_reader :code, :body

  def initialize(endpoint, http_method, json=nil)
    raise ArgumentError unless ALLOWED_METHODS.include? http_method

    @response = HTTP.send http_method, format(ESI, endpoint), json: json

    @code = @response.code
    @body = @response.body
    @time = DateTime.parse @response.headers['Last-Modified']
    @expiry = DateTime.parse @response.headers['Expires']

    change_code_if_server_not_yet_updated
  end

  def ok?
    @response.ok?
  end

  private

  # just in case CCP's API hasn't had time to update
  def change_code_if_server_not_yet_updated
    @code = 503 unless @expiry > DateTime.now()
  end
end
