require 'test_helper'

class RouteTest < ActionDispatch::IntegrationTest
  include I18nSupport

  test 'params' do
    iterate_locales do |locale|

      assert_recognizes(
        { controller: 'namespace/pages', action: 'nested', locale: locale.to_s },
        "/#{locale}/#{t('routes.namespace')}/#{t('routes.nested')}"
      )
      assert_recognizes(
        { controller: 'namespace/resources', action: 'index', locale: locale.to_s },
        "/#{locale}/#{t('routes.namespace')}/#{t('routes.resources')}"
      )
      assert_recognizes(
        { controller: 'namespace/resources', action: 'new', locale: locale.to_s },
        "/#{locale}/#{t('routes.namespace')}/#{t('routes.resources')}/#{t('routes.new')}"
      )
      assert_recognizes(
        { controller: 'namespace/resources', action: 'edit', id: '10', locale: locale.to_s },
        "/#{locale}/#{t('routes.namespace')}/#{t('routes.resources')}/10/#{t('routes.edit')}"
      )
      assert_recognizes(
        { controller: 'pages', action: 'simple', locale: locale.to_s },
        "/#{locale}/#{t('routes.simple')}"
      )
      assert_recognizes(
        { controller: 'pages', action: 'complex', p1: '1', p2: '2', locale: locale.to_s },
        "/#{locale}/complex/1/2"
      )
      assert_recognizes(
        { controller: 'resources', action: 'index', locale: locale.to_s },
        "/#{locale}/#{t('routes.resources')}"
      )
      assert_recognizes(
        { controller: 'resources', action: 'collection', locale: locale.to_s },
        "/#{locale}/#{t('routes.resources')}/#{t('routes.collection')}"
      )
      assert_recognizes(
        { controller: 'resources', action: 'new', locale: locale.to_s },
        "/#{locale}/#{t('routes.resources')}/#{t('routes.new')}"
      )
      assert_recognizes(
        { controller: 'resources', action: 'edit', id: '10', locale: locale.to_s },
        "/#{locale}/#{t('routes.resources')}/10/#{t('routes.edit')}"
      )
      assert_recognizes(
        { controller: 'resources', action: 'member', id: '10', locale: locale.to_s },
        "/#{locale}/#{t('routes.resources')}/10/#{t('routes.member')}"
      )
      assert_recognizes(
        { controller: 'nested', action: 'index', resource_id: '10', locale: locale.to_s },
        "/#{locale}/#{t('routes.resources')}/10/#{t('routes.nested')}"
      )
      assert_recognizes(
        { controller: 'nested', action: 'new', resource_id: '10', locale: locale.to_s },
        "/#{locale}/#{t('routes.resources')}/10/#{t('routes.nested')}/#{t('routes.new')}"
      )
      assert_recognizes(
        { controller: 'nested', action: 'edit', resource_id: '10', id: '4', locale: locale.to_s },
        "/#{locale}/#{t('routes.resources')}/10/#{t('routes.nested')}/4/#{t('routes.edit')}"
      )

      host = "#{locale}.test.host"
      assert_recognizes(
        { controller: 'namespace/pages', action: 'nested', subdomain: locale.to_s },
        "http://#{host}/#{t('routes.namespace')}/#{t('routes.nested')}"
      )
      assert_recognizes(
        { controller: 'namespace/resources', action: 'index', subdomain: locale.to_s },
        "http://#{host}/#{t('routes.namespace')}/#{t('routes.resources')}"
      )
      assert_recognizes(
        { controller: 'namespace/resources', action: 'new', subdomain: locale.to_s },
        "http://#{host}/#{t('routes.namespace')}/#{t('routes.resources')}/#{t('routes.new')}"
      )
      assert_recognizes(
        { controller: 'namespace/resources', action: 'edit', id: '10', subdomain: locale.to_s },
        "http://#{host}/#{t('routes.namespace')}/#{t('routes.resources')}/10/#{t('routes.edit')}"
      )
      assert_recognizes(
        { controller: 'pages', action: 'simple', subdomain: locale.to_s },
        "http://#{host}/#{t('routes.simple')}"
      )
      assert_recognizes(
        { controller: 'pages', action: 'complex', p1: '1', p2: '2', subdomain: locale.to_s },
        "http://#{host}/complex/1/2"
      )
      assert_recognizes(
        { controller: 'resources', action: 'index', subdomain: locale.to_s },
        "http://#{host}/#{t('routes.resources')}"
      )
      assert_recognizes(
        { controller: 'resources', action: 'collection', subdomain: locale.to_s},
        "http://#{host}/#{t('routes.resources')}/#{t('routes.collection')}"
      )
      assert_recognizes(
        { controller: 'resources', action: 'new', subdomain: locale.to_s },
        "http://#{host}/#{t('routes.resources')}/#{t('routes.new')}"
      )
      assert_recognizes(
        { controller: 'resources', action: 'edit', id: '10', subdomain: locale.to_s },
        "http://#{host}/#{t('routes.resources')}/10/#{t('routes.edit')}"
      )
      assert_recognizes(
        { controller: 'resources', action: 'member', id: '10', subdomain: locale.to_s },
        "http://#{host}/#{t('routes.resources')}/10/#{t('routes.member')}"
      )
      assert_recognizes(
        { controller: 'nested', action: 'index', resource_id: '10', subdomain: locale.to_s },
        "http://#{host}/#{t('routes.resources')}/10/#{t('routes.nested')}"
      )
      assert_recognizes(
        { controller: 'nested', action: 'new', resource_id: '10', subdomain: locale.to_s },
        "http://#{host}/#{t('routes.resources')}/10/#{t('routes.nested')}/#{t('routes.new')}"
      )
      assert_recognizes(
        { controller: 'nested', action: 'edit', resource_id: '10', id: '4', subdomain: locale.to_s },
        "http://#{host}/#{t('routes.resources')}/10/#{t('routes.nested')}/4/#{t('routes.edit')}"
      )

      host = domain = "test.#{locale}"
      assert_recognizes(
        { controller: 'namespace/pages', action: 'nested', domain: domain },
        "http://#{host}/#{t('routes.namespace')}/#{t('routes.nested')}"
      )
      assert_recognizes(
        { controller: 'namespace/resources', action: 'index', domain: domain },
        "http://#{host}/#{t('routes.namespace')}/#{t('routes.resources')}"
      )
      assert_recognizes(
        { controller: 'namespace/resources', action: 'new', domain: domain },
        "http://#{host}/#{t('routes.namespace')}/#{t('routes.resources')}/#{t('routes.new')}"
      )
      assert_recognizes(
        { controller: 'namespace/resources', action: 'edit', id: '10', domain: domain },
        "http://#{host}/#{t('routes.namespace')}/#{t('routes.resources')}/10/#{t('routes.edit')}"
      )
      assert_recognizes(
        { controller: 'pages', action: 'simple', domain: domain },
        "http://#{host}/#{t('routes.simple')}"
      )
      assert_recognizes(
        { controller: 'pages', action: 'complex', p1: '1', p2: '2', domain: domain },
        "http://#{host}/complex/1/2"
      )
      assert_recognizes(
        { controller: 'resources', action: 'index', domain: domain },
        "http://#{host}/#{t('routes.resources')}"
      )
      assert_recognizes(
        { controller: 'resources', action: 'collection', domain: domain },
        "http://#{host}/#{t('routes.resources')}/#{t('routes.collection')}"
      )
      assert_recognizes(
        { controller: 'resources', action: 'new', domain: domain },
        "http://#{host}/#{t('routes.resources')}/#{t('routes.new')}"
      )
      assert_recognizes(
        { controller: 'resources', action: 'edit', id: '10', domain: domain },
        "http://#{host}/#{t('routes.resources')}/10/#{t('routes.edit')}"
      )
      assert_recognizes(
        { controller: 'resources', action: 'member', id: '10', domain: domain },
        "http://#{host}/#{t('routes.resources')}/10/#{t('routes.member')}"
      )
      assert_recognizes(
        { controller: 'nested', action: 'index', resource_id: '10', domain: domain },
        "http://#{host}/#{t('routes.resources')}/10/#{t('routes.nested')}"
      )
      assert_recognizes(
        { controller: 'nested', action: 'new', resource_id: '10', domain: domain },
        "http://#{host}/#{t('routes.resources')}/10/#{t('routes.nested')}/#{t('routes.new')}"
      )
      assert_recognizes(
        { controller: 'nested', action: 'edit', resource_id: '10', id: '4', domain: domain },
        "http://#{host}/#{t('routes.resources')}/10/#{t('routes.nested')}/4/#{t('routes.edit')}"
      )

    end
  end

end
