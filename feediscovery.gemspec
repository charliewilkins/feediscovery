# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'feediscovery/version'

Gem::Specification.new do |spec|
  spec.name          = "feediscovery"
  spec.version       = Feediscovery::VERSION
  spec.authors       = ["Charlie"]
  spec.email         = ["charlie@example.com"]
  spec.description   = %q{Provides a wrapper for feed discovery API from http://feediscovery.appspot.com}
  spec.summary       = %q{Provides a wrapper for feed discovery API from http://feediscovery.appspot.com}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "curb"
  spec.add_dependency "google-search"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-nav"
end
