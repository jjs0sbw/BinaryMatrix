# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'binary_matrix/version'

Gem::Specification.new do |spec|
  spec.name          = "binary_matrix"
  spec.version       = BinaryMatrix::VERSION
  spec.authors       = ["Joseph Simpson"]
  spec.email         = ["jjs0sbw@gmail.com"]
  spec.summary       = %q{Binary matrix with Boolean operators.}
  spec.description   = %q{Binary matrix with Boolean operators that implements Warfield augumented Boolean logic.}
  spec.homepage      = ""
  spec.license       = "GPL3"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
