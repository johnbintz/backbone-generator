# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "backbone-generator/version"

Gem::Specification.new do |s|
  s.name        = "backbone-generator"
  s.version     = Backbone::Generator::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["John Bintz"]
  s.email       = ["john@coswellproductions.com"]
  s.homepage    = ""
  s.summary     = %q{Generate Backbone-related files similar to Rails generators.}
  s.description = %q{Generate Backbone-related files similar to Rails generators.}

  s.rubyforge_project = "backbone-generator"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'thor'
  s.add_development_dependency 'rspec'
end
