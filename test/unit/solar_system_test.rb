require 'bundler/setup'

require 'simplecov'
SimpleCov.start
require 'minitest/autorun'

require 'json'
require './lib/solar_system'

# SolarSystem descriptor object tests
class SolarSystemTest < MiniTest::Test
  SAMPLE_JSON = <<~JS.freeze # info for Tzvi
    {
      "contested" : "contested",
      "occupier_faction_id" : 500003,
      "owner_faction_id" : 500003,
      "solar_system_id" : 30002957,
      "victory_points": 500,
      "victory_points_threshold": 3000
    }
  JS

  def setup
    @system_json = JSON.parse(SAMPLE_JSON)
    @system = SolarSystemFactory.from_esi(@system_json)
  end

  def test_to_i_returns_num_plexes
    assert_equal(25, @system.to_i)
  end

  # def test_to_json
  #   answer = ''.concat(
  #     '{"contested":"contested","occupier_faction_id":500003,',
  #     '"owner_faction_id":500003,"solar_system_id":30002957,',
  #     '"victory_points":500,"victory_points_threshold":3000}'
  #   )
  #   assert_equal answer, @system.to_json
  # end

  def test_to_pct_correct_formatting
    expected = '16.7%'
    assert_equal(expected, @system.to_pct)
  end

  def teardown; end
end
