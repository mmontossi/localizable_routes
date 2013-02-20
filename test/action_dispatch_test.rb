require 'test_helper'

class ActionDispatchTest < ActionController::IntegrationTest

  test "should translate subdomain routes" do
    with_routes_type :subdomain do
      Rails.application.config.i18n_routes.mapping.each_pair do |lang, countries|
        countries = [countries] unless countries.is_a? Array
        countries.each do |country|
          I18n.locale = "#{lang}-#{country.upcase}"

          assert_recognizes(
            { :controller => 'namespace/nested', :action => 'nested' },
            "http://#{country}.example.org/#{I18n.t('routes.namespace')}/#{I18n.t('routes.nested')}"
          )

          assert_recognizes(
            { :controller => 'simple', :action => 'simple' },
            "http://#{country}.example.org/#{I18n.t('routes.simple')}",
          )

          assert_recognizes(
            { :controller => 'params', :action => 'params', :p1 => '1', :p2 => '2' },
            "http://#{country}.example.org/params/1/2"
          )

        end
      end    
    end    
  end

  test "should translate prefix routes" do
    with_routes_type :prefix do
      I18n.available_locales.select{|l|l!=:en}.each do |locale|            
        I18n.locale = locale

        assert_recognizes(
          { :controller => 'namespace/nested', :action => 'nested', :locale => locale.to_s },
          "/#{locale}/#{I18n.t('routes.namespace')}/#{I18n.t('routes.nested')}"
        )

        assert_recognizes(
          { :controller => 'simple', :action => 'simple', :locale => locale.to_s },
          "/#{locale}/#{I18n.t('routes.simple')}",
        )

        assert_recognizes(
          { :controller => 'params', :action => 'params', :locale => locale.to_s, :p1 => '1', :p2 => '2' },
          "/#{locale}/params/1/2"
        )

      end
    end
  end

  protected

  def with_routes_type(type)
    Rails.application.config.i18n_routes.selection = type
    with_routing do |set|
      set.draw do
        localized do
          namespace :namespace do
            match 'nested' => 'nested#nested', :as => :nested
          end        
          match 'simple' => 'simple#simple', :as => :simple
          match 'params/:p1/:p2' => 'params#params', :as => :params
        end
      end
      yield
    end
  end

end