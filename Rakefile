require 'bundler/gem_tasks'
require "rake/testtask"

# Run unit + integration tests
Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end

desc 'Re-seed system name caches'
task :re_seed do
  # todo
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
