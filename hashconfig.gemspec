# -*- encoding: utf-8 -*-
require File.expand_path('../lib/hashconfig/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Philipp Böhm"]
  gem.email         = ["philipp@i77i.de"]
  gem.description   = %q{Simple configuration mechanism through serialized hash}
  gem.summary       = %q{Simple configuration mechanism through serialized hash}
  gem.homepage      = "http://github.com/pboehm/hashconfig"

  gem.add_runtime_dependency(%q<hash-deep-merge>)

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "hashconfig"
  gem.require_paths = ["lib"]
  gem.version       = Hashconfig::VERSION
end
