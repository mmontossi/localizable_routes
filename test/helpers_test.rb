require 'test_helper'

class HelpersTest < ActionView::TestCase

  test "should create helpers" do
    I18n.available_locales.each do |locale|
      I18n.locale = locale
      
      assert_equal "/#{locale}/#{I18n.t('routes.namespace')}/#{I18n.t('routes.nested')}", namespace_nested_path
      assert_equal "/#{locale}/#{I18n.t('routes.namespace')}/#{I18n.t('routes.resources')}", namespace_resources_path
      assert_equal "/#{locale}/#{I18n.t('routes.simple')}", simple_path
      assert_equal "/#{locale}/complex/1/2", complex_path(1, 2)
      assert_equal "/#{locale}/#{I18n.t('routes.resources')}", resources_path
    end
  end

end
