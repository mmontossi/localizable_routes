module TranslatableRoutes
  class Railtie < Rails::Railtie

    initializer 'translatable_routes' do
      ::ActionDispatch::Routing::RouteSet::NamedRouteCollection.send :include, TranslatableRoutes::ActionDispatch::NamedRouteCollection
      ::ActionDispatch::Routing::Mapper.send :include, TranslatableRoutes::ActionDispatch::Mapper
    end
 
  end
end
