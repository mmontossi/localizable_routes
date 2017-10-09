$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'localizable_routes/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'localizable_routes'
  s.version     = LocalizableRoutes::VERSION
  s.authors     = ['mmontossi']
  s.email       = ['hi@museways.com']
  s.homepage    = 'https://github.com/museways/localizable_routes'
  s.summary     = 'Localizable routes for rails.'
  s.description = 'Flexible toolkit to localize routes in rails.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.1'

  s.add_development_dependency 'pg', '~> 0.21'
end
