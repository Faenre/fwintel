require "rake/testtask"

desc 'Run the test files'
Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['test/**/*_test.rb']
end

desc 'Run tests (default)'
task default: [:test]
