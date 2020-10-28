require 'bundler/setup'
require 'JSON'

require 'minitest/autorun'

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
    @system = SolarSystem.new(@system_json)
  end

  def test_attributes_have_getters
    @system.score
    @system.current_owner
    @system.status
    assert true
  rescue NoMethodError
    assert false
  end

  def test_attributes_dont_have_setters
    assert_raises(NoMethodError) { @system.score = 1 }
    assert_raises(NoMethodError) { @system.current_owner = 2 }
    assert_raises(NoMethodError) { @system.status = 3 }
  end

  def test_attributes_are_initialized_correctly
    assert_instance_of SystemScore, @system.score
    assert_instance_of Symbol, @system.status
    assert_instance_of Symbol, @system.owner
  end

  # rubocop:disable Style/NumericLiterals
  def test_to_i
    assert_equal(30002957, @system.to_i)
  end
  # rubocop:enable Style/NumericLiterals

  def test_to_s
    assert_equal('Tzvi', @system.to_s)
  end

  def test_to_json
    answer = ''.concat(
      '{"contested":"contested","occupier_faction_id":500003,',
      '"owner_faction_id":500003,"solar_system_id":30002957,',
      '"victory_points":500,"victory_points_threshold":3000}'
    )
    assert_equal answer, @system.to_json
  end

  def test_score_returns_system_score
    assert_instance_of(SystemScore, @system.score)
  end

  # should return score percent as string with formatting
  def test_pct_includes_formatting
    expected = '16.7%'
    assert_equal(expected, @system.pct)
  end

  def teardown; end
end

# Tests for the system score, which turns '1260 victory points'
# into meaningful figures
class SystemScoreTest < MiniTest::Test
  MAX = 3000
  SAMPLE_SCORES = [
    [0, MAX],
    [480, MAX],
    [520, MAX],
    [1280, MAX],
    [MAX, MAX],
    [MAX + 20, MAX]
  ].freeze

  def setup
    @scores = SAMPLE_SCORES.map { |vp, vpmax| SystemScore.new vp, vpmax }
  end

  # confirm these values don't have public accessors
  def test_attribs_should_be_hidden
    assert_raises(NoMethodError) { @scores.sample.vp }
    assert_raises(NoMethodError) { @scores.sample.vp_max }
    assert_raises(NoMethodError) { @scores.sample.get_vp }
    assert_raises(NoMethodError) { @scores.sample.get_vp_max }
  end

  # confirm #to_i returns the number of plexes captured
  def test_to_i
    answers = [0, 24, 26, 34, 100, 101]

    @scores.each_with_index do |score, idx|
      assert_equal(answers[idx], score.to_i)
    end
  end

  def test_to_r
    answers = SAMPLE_SCORES.map { |vp, vp_max| Rational(vp, vp_max) }

    @scores.each_with_index do |score, idx|
      assert_equal(answers[idx], score.to_r)
    end
  end

  # confirm #to_f returns a the percent as float, e.g. 1000vp = .333
  def test_to_f
    answers = SAMPLE_SCORES.map { |vp, vp_max| vp.fdiv vp_max }

    @scores.each_with_index do |score, idx|
      assert_equal(answers[idx], score.to_f)
    end
  end

  # confirm #to_s returns the to_f value, as '33.3' syntax
  def test_to_s
    answers = ['0.0', '16.0', '17.3', '42.7', '100.0', '100.7']

    @scores.each_with_index do |score, idx|
      assert_equal(answers[idx], score.to_s)
    end
  end

  def test_pct
    answers = ['0.0%', '16.0%', '17.3%', '42.7%', '100.0%', '100.7%']

    @scores.each_with_index do |score, idx|
      assert_equal(answers[idx], score.to_s)
    end
  end

  def teardown; end
end
