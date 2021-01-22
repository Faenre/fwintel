require 'bundler/setup'

require 'simplecov'
SimpleCov.start
require 'minitest/autorun'

require 'json'

require './lib/warzone'

SAMPLE_FILE = './test/data/sample_response.json'.freeze
SAMPLE_CONTENT = JSON.parse(File.open(SAMPLE_FILE).read).freeze

# Test the warzone creation suite
class WarzoneFactoryTest < MiniTest::Test
  def setup; end
  def teardown; end

  def test_from_esi
    warzone_mock = MiniTest::Mock.new

    Warzone.stub :new, warzone_mock do
      warzone_mock.expect :new, true

      assert WarzoneFactory.from_json(SAMPLE_CONTENT)
    end
  end

  def test_from_json
    warzone_mock = MiniTest::Mock.new
    response_mock = WebResponseMock.new(JSON.dump(SAMPLE_CONTENT))

    Warzone.stub :new, warzone_mock do
      warzone_mock.expect :new, true

      assert WarzoneFactory.from_web(response_mock)
    end
  end
end

# Test the warzone summary object
class WarzoneTest < MiniTest::Test
  def setup
    @warzone = Warzone.new(SAMPLE_CONTENT)
  end

  def test_warzone_initializes_properly
    assert_instance_of Warzone, @warzone
  end

  def test_attributes_are_initialized_correctly
    assert_instance_of Array, @warzone.systems
    assert(@warzone.systems.all? { |sys| sys.is_a? SolarSystem })
  end

  def test_get_system_by_name
    system_tests = [['Tzvi', 30002957],
                    ['Murethand', 30005295],
                    ['Ladistier', 30004999]]
    system_tests.each do |eve_name, id|
      assert_equal id, @warzone[eve_name].eve_id
    end
  end

  def test_get_system_by_id
    system_tests = [['Tzvi', 30002957],
                    ['Murethand', 30005295],
                    ['Ladistier', 30004999]]
    system_tests.each do |eve_name, id|
      assert_equal eve_name, @warzone[id].eve_name
    end
  end

  def teardown; end
end

class WarzoneDeltaTest < MiniTest::Test
  def setup; end

  def teardown; end
end

class WebResponseMock
  attr_accessor :body

  def initialize(body)
    @body = body
  end
end
