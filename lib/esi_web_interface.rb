require './lib/web_connector'

# connects the ESI data processor to the web connector
class ESIWebInterface
  HOST = 'https://esi.evetech.net/'
  RESOURCE_PREFIX = 'latest/'
  ENDPOINTS = {
    fw_stats: [:get, 'fw/stats/'],
    fw_systems: [:get, 'fw/systems/']
  }

  def self.get_from_endpoint(api_endpoint)
    new(api_endpoint).retrieve
  end

  def initialize(api_endpoint)
    @http_method, @resource = *ENDPOINTS[api_endpoint]
    @resource = RESOURCE_PREFIX + @resource
  end

  def retrieve
    request = Request.new(@http_method, HOST, @resource)
    WebConnector.single(request)
  end
end
