require 'test_helper'

class ActionControllerTest < ActionController::TestCase
  tests SimplesController

  test "should select correct locale by subdomain" do
    Rails.application.config.i18n_routes.selection = :subdomain
    subdomains = []
    Rails.application.config.i18n_routes.mapping.each_pair do |lang, countries|
      countries = [countries] unless countries.is_a? Array
      countries.each do |country|    

        @request.host = "#{country}.example.org"
        get :show
        assert_equal I18n.locale.to_s, "#{lang}-#{country.upcase}"
 
        subdomains << country  

      end
    end
    assert_equal @controller.send(:subdomains), subdomains
  end

  test "should select correct locale by prefix" do
    Rails.application.config.i18n_routes.selection = :prefix 
    I18n.available_locales.select{|l|l!=:en}.each do |locale|
      
      get :show, :locale => locale.to_s
      assert_equal I18n.locale.to_s, locale.to_s

    end
  end

end
