require 'bundler/setup'

require 'minitest/autorun'
require 'json'

require './lib/warzone'

SAMPLE_FILE = './test/sample_response.json'.freeze
SAMPLE_CONTENT = JSON.parse(File.open(SAMPLE_FILE).read).freeze

# Test the warzone creation suite
class WarzoneFactoryTest < MiniTest::Test
  def setup; end

  def test_from_esi
    sample_response = MockHTTP.new
    WarzoneFactory.from_esi(sample_response)
  end

  def teardown; end
end

# Test the warzone summary object
class WarzoneTest < MiniTest::Test
  def setup
    time_now = DateTime.now
    time_future = DateTime.now + 5000
    args = { body: CONTENT, response: 200,
             timestamp: time_now, expiry: time_future }
    @warzone = Warzone.new(*args)
  end

  def test_attributes_have_getters
    @warzone.systems
    @warzone.timestamp
    @warzone.next_update_at
    assert true
  rescue NoMethodError
    assert false
  end

  def test_attributes_dont_have_setters
    assert_raises(NoMethodError) { @warzone.systems = 1 }
    assert_raises(NoMethodError) { @warzone.timestamp = 2 }
    assert_raises(NoMethodError) { @warzone.next_update_at = 3 }
  end

  def test_attributes_are_initialized_correctly
    assert_instance_of Hash, @warzone.systems
    assert_instance_of DateTime, @warzone.timestamp
    assert_instance_of DateTime, @warzone.next_update_at
  end

  def test_subtraction_returns_delta
    assert_instance_of WarzoneDelta, @warzone - @warzone
  end

  def test_expired
    refute @warzone.expired?
  end

  # rubocop:disable Style/NumericLiterals
  def test_get_system_by_name
    system_tests = [['Tzvi', 30002957],
                    ['Murethand', 30005295],
                    ['Ladistier', 30004999]]
    system_tests.each do |name, id|
      assert_equal id, @warzone[name]
    end
  end
  # rubocop:enable Style/NumericLiterals

  def teardown; end
end

class WarzoneDeltaTest < MiniTest::Test
  def setup; end

  def teardown; end
end

# initialization stub
class SolarSystem
  def initialize(*_); end
end

# mock monkey-patch
class MockHTTP
  def body
    SAMPLE_CONTENT
  end

  def code
    200
  end

  def headers
    { 'expires': 'Wed, 28 Oct 2020 21:38:10 GMT ' }
  end
end
