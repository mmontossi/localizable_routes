module TranslatableRoutes
  module ActionDispatch
    module NamedRouteCollection
      extend ActiveSupport::Concern
 
      def define_i18n_url_helper(name)
        %w(path url).each do |type|
          helper = :"#{name}_#{type}"
          @module.remove_possible_method helper
          @module.module_eval do
            define_method helper do |*args|
              options = args.extract_options!
              suffix = (options[:locale] || I18n.locale).to_s.gsub('-', '_').downcase
              send "#{name}_#{suffix}_#{type}", *(args << options)
            end
          end
          helpers << helper
        end
      end
 
    end
  end
end
