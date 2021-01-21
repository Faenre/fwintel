require 'json'

EVE_IDS = JSON.parse(File.read('./data/ids.json'))

class SolarSystemFactory
  def self.from_esi(esi_data)
    solar_system = SolarSystem.new

    solar_system.current_owner = esi_data['occupier_faction_id'].to_i
    solar_system.eve_id = esi_data['solar_system_id'].to_i
    solar_system.eve_name = EVE_IDS[solar_system.eve_id.to_s]
    solar_system.vp_current = esi_data['victory_points'].to_i
    solar_system.vp_max = esi_data['victory_points_threshold'].to_i

    solar_system
  end
end

# SolarSystem description object
class SolarSystem
  SITE_VALUE_PER = 20

  attr_accessor :current_owner, :eve_id, :eve_name, :vp_current, :vp_max

  # supports both esi-json and sql query
  def initialize; end

  def owner
    EVE_IDS[@current_owner.to_s]
  end

  def to_i
    @vp_current / SITE_VALUE_PER
  end

  def to_f
    @vp_current.fdiv @vp_max
  end

  def to_pct(decimals = 1)
    "#{(to_f * 100).round(decimals)}%"
  end
end

# # Summarizes one or more solar systems
# class SystemHistory
#   def initialize(system_name, sql_history)
#     systems = sql_history.select { |row| row[:name] == system_name }
#     @systems = systems.map { |row| System.new(row) }
#     @scores = @systems.map { |s| s.to_i / 20 }

#     @current = @systems.first
#   end

#   def owner; @current.owner; end
#   def to_i; @current.to_i; end
#   def to_f; @current.to_f; end
#   def to_pct(d); @current.to_pct(d); end

#   def net_score_difference
#     (scores.last - scores.first)
#   end

#   def abs_score_total_distance
#     scores.each_cons(2).reduce(0) do |memory, pair|
#       memory + (pair.first - pair.last).abs
#     end
#   end
# end
