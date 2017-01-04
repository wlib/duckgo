# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'duckgo/version'

Gem::Specification.new do |gem|
  gem.name          = "duckgo"
  gem.version       = DuckGo::VERSION
  gem.authors       = ["Daniel Ethridge"]
  gem.email         = ["danielethridge@icloud.com"]
  gem.license = 'MIT'

  gem.summary       = %q{DuckGo is a RubyGem library and command line tool for searching with DuckDuckGo.
By default, it puts out only the relevant information, but when told, it will dump
all the data you could ask for. This tool aims to give access to most of the
features from the official API.}
  gem.homepage      = "https://github.com/wlib/duckgo"

  gem.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  gem.bindir        = "bin"
  gem.executables   = ["duckgo"]
  gem.require_paths = ["lib"]

  gem.add_development_dependency "bundler", "~> 1.13"
  gem.add_development_dependency "rake", "~> 10.0"
end