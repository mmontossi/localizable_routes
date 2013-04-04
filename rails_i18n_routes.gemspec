$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'rails_i18n_routes/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'rails_i18n_routes'
  s.version     = RailsI18nRoutes::VERSION
  s.authors     = ['Mattways']
  s.email       = ['contact@mattways.com']
  s.homepage    = 'https://github.com/mattways/rails_i18n_routes'
  s.summary     = 'Toolkit for Rails i18n routes.'
  s.description = 'Minimalistic toolkit to handle i18n routes and detect locale from subdomain or prefix.'

  s.files = Dir["{app,config,db,lib}/**/*"] + ['MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '>= 3.2.8'

  if RUBY_PLATFORM == 'java'
    s.add_development_dependency 'activerecord-jdbcsqlite3-adapter'
    s.add_development_dependency 'jruby-openssl'
  else
    s.add_development_dependency 'sqlite3'
  end
end
