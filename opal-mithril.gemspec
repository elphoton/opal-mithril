# -*- coding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = 'opal-mithril'
  s.version     = '0.1.0'
  s.authors     = ['El Photon']
  s.email       = 'elphotono@gmail.com'
  s.homepage    = 'https://github.com/elphoton/opal-mithril'
  s.summary     = 'mithril wrapper for opal'
  s.description = 'mithril wrapper for opal'
  s.license     = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency 'opal', '~> 0'
  s.add_development_dependency 'rake', '~> 0'
end
