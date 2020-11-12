# SolarSystem description object
class SolarSystem
  attr_reader :current_owner, :eve_id, :vp_current, :vp_max

  def initialize(json)
    # @status = json['contested']
    @current_owner = json['occupier_faction_id']
    @eve_id = json['solar_system_id']
    @vp_current = json['victory_points']
    @vp_max  = json['victory_points_threshold']
  end
end
