require './lib/web_connector'
require './lib/web_request'

# connects the ESI data processor to the web connector
class ESIWebInterface
  HOST = 'https://esi.evetech.net'
  RESOURCE_PREFIX = '/latest/'
  ENDPOINTS = {
    fw_stats: [:get, 'fw/stats/'],
    fw_systems: [:get, 'fw/systems/']
  }

  def self.get_from_endpoint(api_endpoint, interface=WebConnector)
    new(api_endpoint, interface).retrieve
  end

  def initialize(api_endpoint, interface=WebConnector)
    @http_method, @resource = *ENDPOINTS[api_endpoint]
    @resource = RESOURCE_PREFIX + @resource
    @web_interface = interface
  end

  def retrieve(request_format=WebRequest)
    request = request_format.new(@http_method, HOST, @resource)
    @web_interface.single(request)
  end
end
