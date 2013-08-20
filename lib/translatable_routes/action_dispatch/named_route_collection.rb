module TranslatableRoutes
  module ActionDispatch
    module NamedRouteCollection
      extend ActiveSupport::Concern
      
      def define_i18n_route_helper(name)
        ['url', 'path'].each do |kind|
          helper = :"#{name}_#{kind}"
          @module.remove_possible_method helper
          @module.module_eval do 
            define_method helper do |*args|
              options = args.extract_options!
              if Rails.application.config.translatable_routes.selection == :subdomain
                suffix = (options[:subdomain] ? options[:subdomain] : request.subdomain)
              else
                suffix = (options[:locale] ? options[:locale] : I18n.locale).to_s.gsub('-', '_').downcase
              end
              send ("#{name}_" + suffix.to_s + "_#{kind}"), *(args << options)
            end
          end
          helpers << helper
        end
      end
 
    end
  end
end
