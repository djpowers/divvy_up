# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'divvy_up/version'

Gem::Specification.new do |spec|
  spec.name          = "divvy_up"
  spec.version       = DivvyUp::VERSION
  spec.authors       = ["Dave Powers"]
  spec.email         = ["djpowers89@gmail.com"]
  spec.summary       = %q{Divvy up purchases to split amongst friends}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = "https://github.com/djpowers/divvy_up"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
