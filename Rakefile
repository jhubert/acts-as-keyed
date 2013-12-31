require "rubygems"
require "bundler/setup"
require 'rake/testtask'
require 'rdoc/task'
require 'appraisal'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the restful_authentication plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

Bundler::GemHelper.install_tasks
