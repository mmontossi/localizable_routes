module RailsI18nRoutes
  module ActionDispatch
    module MapperMethods
    
      def localized
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
          @locales.each do |locale|          
            @scope[:path] = i18n_path(@scope[:path], locale) if @scope[:path]
            super(*[i18n_path(action, locale), i18n_options(options, locale)])
          end
          @set.named_routes.define_i18n_route_helper @scope[:as] ? "#{@scope[:as]}_#{options[:as]}" : options[:as] 
          return
        end
        super      
      end     
      
      protected

      def i18n_options(options, locale)
        selection = Rails.application.config.i18n_routes.selection  
        subdomain = locale.to_s.split('-')[1].downcase if selection == :subdomain
        options.merge(
          :constraints => selection == :locale ? {:locale => locale} : {:subdomain => subdomain},
          :as => options[:as] ? "#{options[:as]}_#{selection == :locale ? locale : subdomain}" : nil 
        )
      end
      
      def i18n_path(path, locale)
        i18n_path = [] 
        path.split('/').each do |part|
          next if part == ''
          part.gsub!(/-/, '_')
          i18n_path << ((part[0] == ':' or part[0] == '*') ? part : I18n.t("routes.#{part}", :locale => locale, :default => part.gsub(/_/, '-')))
        end  
        i18n_path.join('/')
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
                suffix = (options[:subdomain] ? options[:subdomain] : request.subdomain)
              else
                suffix = (options[:locale] ? options[:locale] : I18n.locale)
              end
              send ("#{name}_" + suffix.to_s + "_#{kind}"), *(args << options)
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
