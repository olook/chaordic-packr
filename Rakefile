#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << 'lib/chaordic-packr'
  t.test_files = FileList['test/lib/chaordic-packr/*_test.rb']
  t.verbose = true
end
task :default => :test

begin
  require 'yard'

  YARD::Rake::YardocTask.new(:doc) do |task|
    task.files   = ['lib/*.rb', 'lib/**/*.rb']
    task.options = [
      # '--protected',
      # '--private',
      '--output-dir', 'doc'
      # '--title', 'Chaordic Packr'
      # '--markup', 'markdown'
    ]
  end
rescue LoadError
  # If yard is not available, simply supress the exception
end
