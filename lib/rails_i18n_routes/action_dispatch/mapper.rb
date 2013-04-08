module RailsI18nRoutes
  module ActionDispatch
    module Mapper
    
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
            path = @scope[:path].dup if @scope[:path].present?
            path_names = @scope[:path_names].dup
            @scope[:path] = i18n_path(path, locale) if @scope[:path].present?
            @scope[:path_names].each { |key, value| @scope[:path_names][key] = I18n.t("routes.#{key}", :locale => locale, :default => value) }
            super(*[i18n_path(action, locale), i18n_options(options, locale)])
            @scope[:path] = path if @scope[:path].present?
            @scope[:path_names] = path_names
          end
          @set.named_routes.define_i18n_route_helper @scope[:as] ? "#{@scope[:as]}_#{options[:as]}" : options[:as] unless @scope[:scope_level_resource].present?
          return
        end
        super
      end

      protected

      def i18n_options(options, locale)
        selection = Rails.application.config.i18n_routes.selection  
        subdomain = locale.to_s.split('-')[1].downcase if selection == :subdomain
        changes = { :constraints => selection == :prefix ? {:locale => locale.to_s} : {:subdomain => subdomain.to_s} }
        suffix = selection == :prefix ? locale.to_s.gsub('-', '_').downcase : subdomain
        if options[:as].present?
          changes[:as] = "#{options[:as]}_#{suffix}"
        elsif @scope[:scope_level_resource].present?
          resource = @scope[:scope_level_resource]
          ['singular', 'plural'].each do |context|
            resource.instance_variable_set "@original_#{context}".to_sym, resource.send(context.to_sym) unless resource.instance_variable_get "@original_#{context}".to_sym
            resource.instance_variable_set "@#{context}".to_sym, "#{resource.instance_variable_get "@original_#{context}".to_sym}_#{suffix}"
          end
        end
        options.merge changes
      end
      
      def i18n_path(path, locale)
        unless path.is_a? Symbol
          i18n_path = []
          path.split('/').each do |part|
            next if part == ''
            part.gsub!(/-/, '_')
            i18n_path << ((part[0] == ':' or part[0] == '*') ? part : I18n.t("routes.#{part}", :locale => locale, :default => part.gsub(/_/, '-')))
          end  
          i18n_path.join('/')
        else
          path
        end
      end
    
    end
  end
end
