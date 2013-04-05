module RailsI18nRoutes
  module ActionDispatch
    module RouteSet
      module NamedRouteCollection
        
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
                  suffix = (options[:locale] ? options[:locale] : I18n.locale).to_s.gsub('-', '_').downcase
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
end
