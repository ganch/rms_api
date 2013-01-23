# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rms_api/version'

Gem::Specification.new do |gem|
  gem.name          = "rms_api"
  gem.version       = RMSAPI::VERSION
  gem.authors       = ["Dartmouth Web Applications Team"]
  gem.email         = ["web.apps@dartmouth.edu"]
  gem.description   = %q{API Library for access to Dartmouth's resource management systems}
  gem.summary       = %q{API Library for access to Dartmouth's resource management systems}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'json', '~> 1.7.3'

  gem.add_development_dependency 'bundler', '>= 1.2.0'
  gem.add_development_dependency 'rspec', '~> 2.11.0'
end
