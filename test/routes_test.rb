require 'test_helper'

class RoutesTest < ActionDispatch::IntegrationTest

  test "translate routes" do
    I18n.available_locales.each do |locale|
      I18n.locale = locale
      assert_recognizes(
        { controller: 'namespace/pages', action: 'nested', locale: locale.to_s },
        "/#{locale}/#{I18n.t('routes.namespace')}/#{I18n.t('routes.nested')}"
      )
      assert_recognizes(
        { controller: 'namespace/resources', action: 'index', locale: locale.to_s },
        "/#{locale}/#{I18n.t('routes.namespace')}/#{I18n.t('routes.resources')}"
      )
      assert_recognizes(
        { controller: 'namespace/resources', action: 'new', locale: locale.to_s },
        "/#{locale}/#{I18n.t('routes.namespace')}/#{I18n.t('routes.resources')}/#{I18n.t('routes.new')}"
      )
      assert_recognizes(
        { controller: 'namespace/resources', action: 'edit', locale: locale.to_s, id: '10' },
        "/#{locale}/#{I18n.t('routes.namespace')}/#{I18n.t('routes.resources')}/10/#{I18n.t('routes.edit')}"
      )
      assert_recognizes(
        { controller: 'pages', action: 'simple', locale: locale.to_s },
        "/#{locale}/#{I18n.t('routes.simple')}"
      )
      assert_recognizes(
        { controller: 'pages', action: 'complex', locale: locale.to_s, p1: '1', p2: '2' },
        "/#{locale}/complex/1/2"
      )
      assert_recognizes(
        { controller: 'resources', action: 'index', locale: locale.to_s },
        "/#{locale}/#{I18n.t('routes.resources')}"
      )
      assert_recognizes(
        { controller: 'resources', action: 'new', locale: locale.to_s },
        "/#{locale}/#{I18n.t('routes.resources')}/#{I18n.t('routes.new')}"
      )
      assert_recognizes(
        { controller: 'resources', action: 'edit', locale: locale.to_s, id: '10' },
        "/#{locale}/#{I18n.t('routes.resources')}/10/#{I18n.t('routes.edit')}"
      )
    end
  end

end
