# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "acts_as_keyed/version"

Gem::Specification.new do |s|
  s.name        = "acts_as_keyed"
  s.version     = ActsAsKeyed::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jeremy Hubert"]
  s.email       = ["jhubert@gmail.com"]
  s.homepage    = "http://github.com/jhubert/acts_as_keyed"
  s.summary     = %q{Automatically key an active record model with a unique key}
  s.description = %q{A simple plugin that automatically generates a key for a model on create. It takes care of protecting the key, automatically generating it and making sure it is unique.}

  s.rubyforge_project = "acts_as_keyed"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
