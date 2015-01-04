# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinatras/version'

Gem::Specification.new do |spec|
  spec.name          = "sinatras"
  spec.version       = Sinatras::VERSION
  spec.authors       = ["Tomcha"]
  spec.email         = ["tomcha@tomcha.net"]
  spec.summary       = %q{TODO sinatra's webapplication skelton make tool}
  spec.description   = %q{TODO sinatra's app make tool}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
