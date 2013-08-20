module TranslatableRoutes
  class Railtie < Rails::Railtie

    config.translatable_routes = ActiveSupport::OrderedOptions.new
    config.translatable_routes.selection = :prefix

    initializer 'translatable_routes' do
      ::ActionDispatch::Routing::Mapper.send :include, TranslatableRoutes::ActionDispatch::Mapper
      ::ActionDispatch::Routing::RouteSet::NamedRouteCollection.send :include, TranslatableRoutes::ActionDispatch::NamedRouteCollection
      ::ActionController::Base.send :include, TranslatableRoutes::ActionController::Base
    end
  
  end
end
