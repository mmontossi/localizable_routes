require 'test_helper'

class RoutesTest < ActionDispatch::IntegrationTest

  test "should translate subdomain routes" do
    with_routes_type :subdomain do
      Rails.application.config.translatable_routes.mapping.each_pair do |lang, countries|
        countries = [countries] unless countries.is_a? Array
        countries.each do |country|
          I18n.locale = "#{lang}-#{country.upcase}"

          assert_recognizes(
            { controller: 'namespace/nested_resources', action: 'show', subdomain: country.to_s },
            "http://#{country}.example.org/#{I18n.t('routes.namespace')}/#{I18n.t('routes.nested_resources')}"
          )

          assert_recognizes(
            { controller: 'namespace/nested', action: 'show', subdomain: country.to_s },
            "http://#{country}.example.org/#{I18n.t('routes.namespace')}/#{I18n.t('routes.nested')}"
          )

          assert_recognizes(
            { controller: 'simple', action: 'show', subdomain: country.to_s },
            "http://#{country}.example.org/#{I18n.t('routes.simple')}"
          )

          assert_recognizes(
            { controller: 'params', action: 'show', p1: '1', p2: '2', subdomain: country.to_s },
            "http://#{country}.example.org/params/1/2"
          )

          assert_recognizes(
            { controller: 'resources', action: 'show', subdomain: country.to_s },
            "http://#{country}.example.org/#{I18n.t('routes.resources')}"
          )

        end
      end    
    end    
  end

  test "should translate prefix routes" do
    with_routes_type :prefix do
      I18n.available_locales.select{ |l| l != :en }.each do |locale|            
        I18n.locale = locale

        assert_recognizes(
          { controller: 'namespace/nested', action: 'show', locale: locale.to_s },
          "/#{locale}/#{I18n.t('routes.namespace')}/#{I18n.t('routes.nested')}"
        )

        assert_recognizes(
          { controller: 'namespace/nested_resources', action: 'show', locale: locale.to_s },
          "/#{locale}/#{I18n.t('routes.namespace')}/#{I18n.t('routes.nested_resources')}"
        )

        assert_recognizes(
          { controller: 'simple', action: 'show', locale: locale.to_s },
          "/#{locale}/#{I18n.t('routes.simple')}"
        )

        assert_recognizes(
          { controller: 'params', action: 'show', locale: locale.to_s, p1: '1', p2: '2' },
          "/#{locale}/params/1/2"
        )

        assert_recognizes(
          { controller: 'resources', action: 'show', locale: locale.to_s },
          "/#{locale}/#{I18n.t('routes.resources')}"
        )

      end
    end
  end

  protected

  def with_routes_type(type)
    Rails.application.config.translatable_routes.selection = type
    with_routing do |set|
      set.draw do
        localized do
          namespace :namespace do
            get 'nested', to: 'nested#show', as: :nested
            resource :nested_resources
          end        
          get 'simple', to: 'simple#show', as: :simple
          get 'params/:p1/:p2', to: 'params#show', as: :params
          resource :resources
        end
      end
      yield
    end
  end

end
