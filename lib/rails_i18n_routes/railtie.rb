module RailsI18nRoutes
  class Railtie < Rails::Railtie

    config.i18n_routes = ActiveSupport::OrderedOptions.new
    config.i18n_routes.selection = :prefix

    initializer 'rails_i18n_routes' do
      ::ActionDispatch::Routing::Mapper.send :include, RailsI18nRoutes::ActionDispatch::Mapper
      ::ActionDispatch::Routing::RouteSet::NamedRouteCollection.send :include, RailsI18nRoutes::ActionDispatch::RouteSet::NamedRouteCollection
      ::ActionController::Base.send :include, RailsI18nRoutes::ActionController::Base
    end
  
  end
end
