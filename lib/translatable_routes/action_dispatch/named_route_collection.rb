module TranslatableRoutes
  module ActionDispatch
    module NamedRouteCollection
      extend ActiveSupport::Concern

      def define_i18n_url_helper(name)
        %w(path url).each do |type|
          helper = :"#{name}_#{type}"

          if Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR >= 2
            target = instance_variable_get("@#{type}_helpers_module")
          else
            target = @module
          end

          target.remove_possible_method helper
          target.module_eval do
            define_method helper do |*args|
              options = args.extract_options!
              suffix = (options[:locale] || url_options[:locale] || I18n.locale).to_s.gsub('-', '_').downcase
              send "#{name}_#{suffix}_#{type}", *(args << options)
            end
          end

          if Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR >= 2
            instance_variable_get("@#{type}_helpers") << helper
          else
            helpers << helper
          end
        end
      end

    end
  end
end
