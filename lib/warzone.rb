class WarzoneFactory
  def self.from_esi(response); end

  def self.from_json(json); end
end

# Summary object to describe and navigate the contents of /fw/systems/
class Warzone
  include Enumerable

  def initialize(body, response_code, timestamp, expiry); end

  def []; end

  def each; end
end

class WarzoneDelta
end
