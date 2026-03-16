# frozen_string_literal: true

require_relative 'lib/legion/extensions/cognitive_momentum/version'

Gem::Specification.new do |spec|
  spec.name    = 'lex-cognitive-momentum'
  spec.version = Legion::Extensions::CognitiveMomentum::VERSION
  spec.authors = ['Esity']
  spec.email   = ['matthewdiverson@gmail.com']

  spec.summary     = 'Physics-inspired cognitive dynamics for LegionIO'
  spec.description = 'Models ideas with mass (importance) and velocity (change rate). ' \
                     'Heavy ideas resist change (inertia), reinforced ideas accelerate, ' \
                     'friction slows unreinforced ideas. Based on Newtonian dynamics metaphor.'
  spec.homepage    = 'https://github.com/LegionIO/lex-cognitive-momentum'
  spec.license     = 'MIT'

  spec.required_ruby_version = '>= 3.4'

  spec.metadata['homepage_uri']      = spec.homepage
  spec.metadata['source_code_uri']   = 'https://github.com/LegionIO/lex-cognitive-momentum'
  spec.metadata['documentation_uri'] = 'https://github.com/LegionIO/lex-cognitive-momentum'
  spec.metadata['changelog_uri']     = 'https://github.com/LegionIO/lex-cognitive-momentum/blob/master/CHANGELOG.md'
  spec.metadata['bug_tracker_uri']   = 'https://github.com/LegionIO/lex-cognitive-momentum/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir['lib/**/*', 'LICENSE', 'README.md']
  spec.require_paths = ['lib']
  spec.add_development_dependency 'legion-gaia'
end
