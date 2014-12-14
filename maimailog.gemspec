# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'maimailog/version'

Gem::Specification.new do |spec|
  spec.name          = "maimailog"
  spec.version       = Maimailog::VERSION
  spec.authors       = ["utahta"]
  spec.email         = ["labs.ninxit@gmail.com"]
  spec.summary       = %q{get the maimai play log}
  spec.description   = %q{get the maimai play log}
  spec.homepage      = "https://github.com/utahta/maimailog"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.1.0'

  spec.add_dependency 'mechanize', '~> 2.7.3'
  spec.add_dependency 'thor', '~> 0.19.1'
end
