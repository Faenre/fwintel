# SolarSystem description object
class SolarSystem
  attr_reader :score, :current_owner, :status

  def initialize(json); end

  def to_i; end

  def to_s; end

  def pct; end

  def plexes; end

  def -(other); end
end

# Score object to describe (vp/vp_max) in varying methods
class SystemScore
  def initialize(vp_current, vp_max = 3000); end

  def to_i; end

  def to_f; end

  def to_r; end

  def to_s; end

  def pct; end

  def -(other); end
end
