module LocalizableRoutes
  module Extensions
    module ActionDispatch
      module Mapper
        extend ActiveSupport::Concern

        def initialize(set)
          super
          @localization = @locale = nil
        end

        def localized(options)
          @localization = options
          if options[:strategy] == :param
            scope(':locale') do
              yield
            end
          else
            yield
          end
          @localization = nil
        end

        def add_route(action, controller, options, _path, to, via, formatted, anchor, options_constraints)
          if @localization
            strategy = @localization[:strategy]
            @localization[:locales].each do |locale|
              localized_options = options.dup
              localized_options_constraints = options_constraints.dup
              if strategy == :param
                @locale = locale
                localized_options[:locale] = locale
                localized_options_constraints[:locale] = locale
              else
                @locale = locale.second
                localized_options[strategy] = locale.first
                localized_options_constraints[strategy] = locale.first
              end
              super action, controller, localized_options, _path, to, via, formatted, anchor, localized_options_constraints
            end
            @locale = nil
            if options.fetch(:as, true)
              @set.named_routes.add_localized_url_helper name_for_action(options[:as], action), @localization
            end
          else
            super
          end
        end

        def name_for_action(as, action)
          candidate = super
          if candidate && @locale
            suffixed_candidate = "#{super}_#{@locale}"
            unless @set.named_routes.key?(suffixed_candidate)
              suffixed_candidate
            end
          else
            candidate
          end
        end

        def path_for_action(action, path)
          candidate = super
          if candidate && @locale
            candidate.gsub(/:?[a-z0-9_-]+/) do |slug|
              if slug =~ /^[\:]/
                slug
              else
                I18n.t "routes.#{slug.gsub('-', '_')}", locale: @locale.to_s, default: slug
              end
            end
          else
            candidate
          end
        end

      end
    end
  end
end
