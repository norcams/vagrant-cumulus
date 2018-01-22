# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-cumulus/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-cumulus"
  spec.version       = VagrantPlugins::GuestCumulus::VERSION
  spec.authors       = ["Dinesh Dutt"]
  spec.email         = ["ddutt@cumulusnetworks.com"]
  spec.summary       = %q{Guest capabilities for Cumulus Linux}
  spec.description   = %q{Primarily to rename interfaces to match Cumulus Linux front panel port names}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
