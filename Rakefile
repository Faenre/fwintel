require 'bundler/gem_tasks'
require "rake/testtask"

# Run unit + integration tests
Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end

desc 'Re-seed system name caches'
task :reseed do
  require 'http'
  require 'json'

  CACHE_FILE = 'ids.json'
  ESI_BASE = 'https://esi.evetech.net/latest'
  FACTIONS = ESI_BASE + '/universe/factions/'
  FW = ESI_BASE + '/fw/systems/'
  NAMES = ESI_BASE + '/universe/names/'

  factions = HTTP.get(FACTIONS).parse.map do |info|
    [info['faction_id'].to_i, info['name']]
  end.to_h

  systems = HTTP.get(FW).parse.map { |info| info['solar_system_id'] }
  systems = HTTP.post(NAMES, json: systems).parse.map do |info|
    [info['id'].to_i, info['name']]
  end.to_h

  File.open(CACHE_FILE, 'w') { |f| f.write JSON.dump(systems.merge(factions)) }
end

desc 'Test for deleted webhooks'
task :webhook_verification do
  # todo
end

desc 'Send announcement to all webhooks'
task :send_announcement do
  # todo
end

desc 'Run tests (default)'
task :default => [:test]
