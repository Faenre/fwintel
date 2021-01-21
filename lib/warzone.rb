require 'json'
require './lib/solar_system'

class WarzoneFactory
  def self.from_web(response)
    from_json JSON.parse(response.body)
  end

  def self.from_json(json)
    Warzone.new(json)
  end
end

# Summary object to describe and navigate the contents of /fw/systems/
class Warzone
  attr_reader :systems

  def initialize(body)
    @systems = body.map { |system| SolarSystemFactory.from_esi(system) }
  end

  def [](key)
    case key.class.to_s
    when 'Integer'  then @systems.detect { |sys| sys.eve_id == key }
    when 'String'   then @systems.detect { |sys| sys.eve_name == key }
    end
  end

  def tally_by_faction
    @systems.map(&:owner).tally
  end
end

class WarzoneDelta
  def initialize; end
end
