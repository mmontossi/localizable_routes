module TranslatableRoutes
  module ActionDispatch
    module Mapper
      extend ActiveSupport::Concern

      def localized
        @locales = I18n.available_locales
        scope(':locale') { yield }
        @locales = nil
      end

      def add_route(action, options)
        if @locales
          @locales.each do |locale|
            if @scope[:scope_level_resource] && @scope.resource_method_scope?
              original_scope_level_resource = @scope[:scope_level_resource].dup
            end
            if @scope[:path]
              original_path = @scope[:path].dup
            end
            original_path_names = @scope[:path_names].dup
            original_options = options.dup
            @scope[:path] = i18n_path(@scope[:path], locale)
            @scope[:path_names].each do |key, value|
              @scope[:path_names][key] = i18n_path(value, locale)
            end
            options[:path] = i18n_path(options[:path], locale)
            (options[:constraints] ||= {}).merge!(locale: locale.to_s)
            (options[:defaults] ||= {}).merge!(locale: locale.to_s)
            if @scope[:scope_level_resource] && @scope.resource_method_scope?
              resource = @scope[:scope_level_resource].dup
              %w(collection_name member_name).each do |method|
                resource.class_eval do
                  define_method method do
                    "#{super()}_#{locale}"
                  end
                end
              end
              @scope[:scope_level_resource] = resource
            else
              options[:as] = "#{options[:as] || action}_#{locale}"
            end
            super i18n_path(action, locale), options
            if @scope[:scope_level_resource] && @scope.resource_method_scope?
              @scope[:scope_level_resource] = original_scope_level_resource
            end
            if @scope[:path]
              @scope[:path] = original_path
            end
            @scope[:path_names] = original_path_names
            options = original_options
          end
          if @scope[:scope_level_resource] && @scope.resource_method_scope?
            helper = name_for_action(options[:as], action)
            @set.named_routes.define_i18n_url_helper helper
          else
            helper = "#{options[:as] || action}"
            if @scope[:as]
              helper.prepend "#{@scope[:as]}_"
            end
            @set.named_routes.define_i18n_url_helper helper
          end
        else
          super
        end
      end

      protected

      def i18n_path(path, locale)
        case path
        when String
          path.gsub(/:?[a-z0-9_-]+/) do |match|
            if match.starts_with?(':')
              match
            else
              I18n.t(
                "routes.#{match.gsub('-', '_')}",
                locale: locale.to_s,
                default: match.gsub('_', '-')
              )
            end
          end
        when Symbol
          path
        end
      end

    end
  end
end
