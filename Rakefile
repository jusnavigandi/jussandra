require 'rubygems'
require 'rake'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.test_files=Dir.glob( "test/**/*_test.rb" ).sort
  t.verbose = true
end

Rake::TestTask.new(:legacy_test) do |t|
  t.libs << "test/legacy"
  t.libs << "test"
  t.test_files=Dir.glob( "test/**/*_test.rb" ).sort
  t.verbose = true
end

task :cleanup do
  unless defined?(Jussandra)
    $: << 'test'
    $: << 'lib'
    require 'test_helper'
  end
  puts "Clearing keyspace! ..."
  Jussandra::Base.connection.clear_keyspace!
  puts "Cleared"
end

task :config_snippet do
  unless defined?(Jussandra)
    $: << 'test'
    $: << 'lib'
    require 'test_helper'
  end
  
  puts Jussandra::Base.storage_config_xml
end

task :default=>[:test, :cleanup] do
end

