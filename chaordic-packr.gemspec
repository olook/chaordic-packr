# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chaordic-packr/version'

Gem::Specification.new do |gem|
  gem.name          = "chaordic-packr"
  gem.version       = Chaordic::Packr::VERSION
  gem.authors       = ["Julio Monteiro", "Matheus Rossato"]
  gem.email         = ["julio@monteiro.eti.br", "rossato@chaordicsystems.com"]
  gem.description   = %q{Integration with Chaordic's infrastructure, packing and unpacking product-related information with AES 128bit cryptography.}
  gem.summary       = %q{Integration with Chaordic's infrastructure}
  gem.homepage      = "http://www.chaordicsystems.com"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'oj'
  gem.add_development_dependency 'addressable'

  gem.add_development_dependency 'minitest', '~> 4.3.0'
  gem.add_development_dependency 'yard', '~> 0.8.3'
  gem.add_development_dependency 'rdiscount', '~> 1.6.8'
end
