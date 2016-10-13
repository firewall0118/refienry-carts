# Encoding: UTF-8

Gem::Specification.new do |s|
  s.author            = "AIDC - Chloe Sowers, Brian Gates"
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-carts'
  s.version           = '2.8.2'
  s.description       = 'Ruby on Rails Carts extension for Refinery CMS'
  s.date              = '2014-11-19'
  s.summary           = 'Carts extension for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"] + ["readme.md"]

  # Runtime dependencies
  s.add_dependency             'refinerycms-core',    '~> 2.1.1'

  # Development dependencies (usually used for testing)
  s.add_development_dependency 'refinerycms-testing', '~> 2.1.1'
end
