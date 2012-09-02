module RailsI18nRoutes
  class Railtie < Rails::Railtie

    config.i18n_routes = ActiveSupport::OrderedOptions.new
    config.i18n_routes.selection = :prefix
  
  end
end