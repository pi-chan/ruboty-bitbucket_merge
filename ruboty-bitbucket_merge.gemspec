# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruboty/bitbucket_merge/version'

Gem::Specification.new do |spec|
  spec.name          = "ruboty-bitbucket_merge"
  spec.version       = Ruboty::BitbucketMerge::VERSION
  spec.authors       = ["xoyip"]
  spec.email         = ["xoyip@piyox.info"]
  spec.summary       = %q{To merge branches on bitbucket via Ruboty.}
  spec.homepage      = "https://github.com/xoyip/ruboty-bitbucket_merge"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "ruboty"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
