require './lib/esi_web_interface'
require './lib/warzone'

class ESIHandler
  def self.warzone_status
    esi_response = ESIWebInterface.get_from_endpoint(:fw_systems)
    # todo: check datetime, raise errors, ...
    # todo: log request info, ...

    WarzoneFactory.from_web(esi_response)
  end
end
