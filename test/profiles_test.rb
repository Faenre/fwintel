require 'bundler/setup'

require 'simplecov'
SimpleCov.start
require 'minitest/autorun'

require './lib/profiles'

class CorpProfileTest < MiniTest::Test
  def setup; end

  def teardown; end
end

class WatchlistTest < MiniTest::Test
  def setup; end

  def teardown; end
end
