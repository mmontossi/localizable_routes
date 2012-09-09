module RailsI18nRoutes
  module ActionDispatch
    module MapperMethods
    
      def localize
        @locales = I18n.available_locales.dup
        case Rails.application.config.i18n_routes.selection
        when :prefix
          scope ':locale' do
            yield
          end
        when :subdomain
          @locales.shift # For some reason :en is always there
          yield
        end    
        @locales = nil # Needed to routes below localize block to work
      end
      
      def add_route(action, options)
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
              subdomain = locale.to_s.split('_')[1].to_sym
              super(i18n_path.join('/'), options.merge(
                :constraints => {:subdomain => subdomain},
                :as => (options[:as] ? "#{options[:as]}_#{subdomain}" : nil)            
              ))                
            else    
              super(i18n_path.join('/'), options.merge(
                :constraints => {:locale => locale},
                :as => (options[:as] ? "#{options[:as]}_#{locale}" : nil)            
              ))                       
            end
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
              if Rails.application.config.i18n_routes.selection == :subdomain
                suffix = request.subdomain
              else
                suffix = (options[:locale] ? options[:locale] : I18n.locale)
              end
              send ("#{name}_" + suffix + "_#{kind}"), options
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
