# -*- encoding: utf-8 -*-
require File.expand_path('../lib/smokey_bear/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Darcy Laycock"]
  gem.email         = ["sutto@sutto.net"]
  gem.description   = %q{Tools for testing JSON-based APIs}
  gem.summary       = %q{Smokey Bear provides a set of tools orentied towards making it easy to test HTTP and JSON based APIS.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "smokey_bear"
  gem.require_paths = ["lib"]
  gem.version       = SmokeyBear::VERSION

  gem.add_dependency 'rest-client'
  gem.add_dependency 'multi_json'
end
