# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "acts_as_keyed/version"

Gem::Specification.new do |s|
  s.name        = "acts_as_keyed"
  s.version     = ActsAsKeyed::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jeremy Hubert"]
  s.email       = ["jhubert@gmail.com"]
  s.homepage    = "https://github.com/jhubert/acts-as-keyed"
  s.summary     = %q{Automatically key an active record model with a unique key}
  s.description = %q{A simple plugin that automatically generates a key for a model on create. It takes care of protecting the key, automatically generating it and making sure it is unique.}
  s.license     = "The MIT License (MIT)"

  s.rubyforge_project = "acts_as_keyed"

  if File.exists?('UPGRADING')
    s.post_install_message = File.read('UPGRADING')
  end

  s.add_dependency "activerecord", ">= 3.0.0"
  s.add_development_dependency "rake"
  s.add_development_dependency "activesupport", ">= 3.0.0"
  s.add_development_dependency "sqlite3-ruby"
  s.add_development_dependency "appraisal"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.require_paths = ["lib"]
end
