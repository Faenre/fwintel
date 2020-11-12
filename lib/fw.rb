require './lib/esi'
require './lib/solar_system'

class FWStatus
  ENDPOINT = ['fw/status', :get].freeze

  def initialize
    query_api
    create_systems
  end

  def code
    @response.code
  end

  private

  def query_api
    @response = ESIHandler.new(*ENDPOINT)
  end

  def create_systems
    return (@systems = {}) unless @response.ok?

    @systems = @response.body.map do |json|
      system = SolarSystem.new(json)
      [system.eve_id, system]
    end.to_h
  end
end
