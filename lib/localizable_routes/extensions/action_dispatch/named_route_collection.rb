module LocalizableRoutes
  module Extensions
    module ActionDispatch
      module NamedRouteCollection
        extend ActiveSupport::Concern

        def add_localized_url_helper(name, localization)
          %w(path url).each do |type|
            helper = :"#{name}_#{type}"
            target = instance_variable_get("@#{type}_helpers_module")
            target.remove_possible_method helper
            target.module_eval do
              define_method helper do |*args|
                options = args.extract_options!
                strategy = localization[:strategy]
                if strategy == :param
                  locale = options[:locale]
                else
                  key = options[strategy]
                  locale = localization[:locales][key.to_s]
                end
                send "#{name}_#{locale || I18n.locale}_#{type}", *(args << options)
              end
            end
            instance_variable_get("@#{type}_helpers") << helper
          end
        end

      end
    end
  end
end
