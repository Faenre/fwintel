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

  ID_CACHE_FILE = 'ids.json'
  ESI_BASE = 'https://esi.evetech.net/latest'
  FW = ESI_BASE + '/fw/systems/'
  NAMES = ESI_BASE + '/universe/names/'

  fw_system_ids = HTTP.get(FW).parse.map { |info| info['solar_system_id'] }

  ids_with_names = HTTP.post(NAMES, json: fw_system_ids).parse.map do |info|
    [info['id'], info['name']]
  end.to_h

  File.open(ID_CACHE_FILE, 'w') { |f| f.write JSON.dump(ids_with_names) }
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
