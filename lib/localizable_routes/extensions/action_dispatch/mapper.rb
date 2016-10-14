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

        def add_route(action, options)
          if @localization
            @localization[:locales].each do |locale|
              localized_options = options.dup
              localized_options[:constraints] ||= {}
              localized_options[:defaults] ||= {}
              strategy = @localization[:strategy]
              if strategy == :param
                @locale = locale
                localized_options[:constraints][:locale] = locale
                localized_options[:defaults][:locale] = locale
              else
                @locale = locale.second
                localized_options[:constraints][strategy] = locale.first
                localized_options[:defaults][strategy] = locale.first
              end
              super action, localized_options
            end
            @locale = nil
            if options.fetch(:as, true)
              @set.named_routes.define_localized_url_helper(
                name_for_action(options[:as], action),
                @localization
              )
            end
          else
            super
          end
        end

        def name_for_action(as, action)
          candidate = super
          if candidate && @locale
            suffixed_candidate = "#{super}_#{@locale}"
            if !as.nil? || !@set.named_routes.routes.has_key?(suffixed_candidate.to_sym)
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
