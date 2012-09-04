module RailsI18nRoutes
  module ActionDispatch
    module MapperMethods
    
      def localize
        @locales = I18n.available_locales
        case Rails.application.config.i18n_routes.selection
        when :prefix
          scope ':locale', :locale => Regexp.new("/#{I18n.available_locales.join('|')}/") do
            yield
          end
        when :subdomain
          yield
        end    
        @locales = nil # Needed to routes below localize block to work
      end
      
      def add_route(action, options) # :nodoc:
        if @locales
          @set.named_routes.define_i18n_route_helper options[:as] if options[:as]
          @locales.each do |locale|
            i18n_path = [] 
            action.split('/').each do |part|
              part.gsub!(/-/, '_')
              i18n_path << ((part[0] == ':' or part[0] == '*') ? part : I18n.t("routes.#{part}", :locale => locale, :default => part))
            end
            constraints = {}
            if Rails.application.config.i18n_routes.selection == :subdomain
              constraints[:subdomain] = Rails.application.config.i18n_routes.mapping[locale]
            else
              constraints[:locale] = locale              
            end
            super(i18n_path.join('/'), options.merge(
              :constraints => constraints,
              :as => (options[:as] ? "#{options[:as]}_#{locale}" : nil)            
            ))
          end
          return
        end
        super      
      end     
    
    end
    module NamedRouteCollectionMethods
      
      def define_i18n_route_helper(name)
        ['url', 'path'].each do |kind|
          selector = url_helper_name(name, kind)
        
          @module.module_eval <<-END_EVAL, __FILE__, __LINE__ + 1
            remove_possible_method :#{selector}
            def #{selector}(*args)
              options = args.extract_options!
              lang = options[:locale] ? options[:locale] : I18n.locale
              send ("#{name}_" + lang.to_s + "_#{kind}"), options
            end
          END_EVAL
            
          helpers << selector
        end                
      end    
    
    end
  end
end

ActionDispatch::Routing::Mapper.send :include, RailsI18nRoutes::ActionDispatch::MapperMethods
ActionDispatch::Routing::RouteSet::NamedRouteCollection.send :include, RailsI18nRoutes::ActionDispatch::NamedRouteCollectionMethods
