require 'bundler/setup'

require 'simplecov'
SimpleCov.start
require 'minitest/autorun'

require './lib/discord'

class DiscordHandlerTest < MiniTest::Test
  def setup; end

  def teardown; end
end
