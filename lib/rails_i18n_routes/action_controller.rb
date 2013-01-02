module RailsI18nRoutes
  module ActionController
    module BaseMethods
      
      def self.included(base)
        base.send :prepend_before_filter, :select_locale
      end
      
      protected
      
      def select_locale
        if Rails.application.config.i18n_routes.selection == :subdomain
          Rails.application.config.i18n_routes.mapping.each_pair do |key, value|
            if (value.is_a? Array and value.include? request.subdomain.to_sym) or value == request.subdomain.to_sym
              I18n.locale = "#{key}-#{request.subdomain.upcase}" 
              break
            end
          end
        elsif not params[:locale].nil?
          I18n.locale = params[:locale] 
        end       
      end
      
      def subdomains
        @subdomains ||= begin
          values = []
          Rails.application.config.i18n_routes.mapping.values.each do |value|
            value = [value] unless value.is_a? Array
            values.concat value
          end
          values
        end
      end
      
    end
  end
end

ActionController::Base.send :include, RailsI18nRoutes::ActionController::BaseMethods
