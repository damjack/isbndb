# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'isbndb/version'

Gem::Specification.new do |s|
  s.name        = 'isbndb'
  s.version     =  ISBNdb::VERSION
  s.authors         = ["Seth Vargo", "Damiano Giacomello"]
  s.email           = ["sethvargo@gmail.com", "giacomello.damiano@gmail.com"]
  s.homepage        = 'https://github.com/damjack/isbndb'
  s.summary         = 'Connect with ISBNdb.com\'s API'
  s.description     = 'Ruby ISBNdb is a amazingly fast and accurate gem that reads ISBNdb.com\'s JSON API and gives you incredible flexibilty with the results! The newest version of the gem also features caching, so developers minimize API-key usage.'

  s.files           = `git ls-files`.split($/)
  s.executables     = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files      = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths   = ["lib"]

  s.add_dependency 'httparty'
  s.add_dependency 'virtus'
  s.add_dependency 'activesupport'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'vcr'
end
