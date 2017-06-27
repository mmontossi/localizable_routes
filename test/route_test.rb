require 'test_helper'

class RouteTest < ActionDispatch::IntegrationTest
  include I18nSupport

  test 'params' do
    iterate_locales do |locale|

      assert_recognizes(
        { controller: 'pages', action: 'index', locale: locale.to_s },
        "/#{locale}"
      )
      assert_recognizes(
        { controller: 'pages', action: 'about', locale: locale.to_s },
        "/#{locale}/#{t('routes.about')}"
      )
      assert_recognizes(
        { controller: 'admin/pages', action: 'index', locale: locale.to_s },
        "/#{locale}/#{t('routes.admin')}"
      )
      assert_recognizes(
        { controller: 'admin/users', action: 'index', locale: locale.to_s },
        "/#{locale}/#{t('routes.admin')}/#{t('routes.users')}"
      )
      assert_recognizes(
        { controller: 'admin/users', action: 'new', locale: locale.to_s },
        "/#{locale}/#{t('routes.admin')}/#{t('routes.users')}/#{t('routes.new')}"
      )
      assert_recognizes(
        { controller: 'admin/users', action: 'edit', id: '1', locale: locale.to_s },
        "/#{locale}/#{t('routes.admin')}/#{t('routes.users')}/1/#{t('routes.edit')}"
      )
      assert_recognizes(
        { controller: 'shops', action: 'index', locale: locale.to_s },
        "/#{locale}/#{t('routes.shops')}"
      )
      assert_recognizes(
        { controller: 'shops', action: 'search', locale: locale.to_s },
        "/#{locale}/#{t('routes.shops')}/#{t('routes.search')}"
      )
      assert_recognizes(
        { controller: 'shops', action: 'new', locale: locale.to_s },
        "/#{locale}/#{t('routes.shops')}/#{t('routes.new')}"
      )
      assert_recognizes(
        { controller: 'shops', action: 'edit', id: '1', locale: locale.to_s },
        "/#{locale}/#{t('routes.shops')}/1/#{t('routes.edit')}"
      )
      assert_recognizes(
        { controller: 'shops', action: 'info', id: '1', locale: locale.to_s },
        "/#{locale}/#{t('routes.shops')}/1/#{t('routes.info')}"
      )
      assert_recognizes(
        { controller: 'products', action: 'index', shop_id: '1', locale: locale.to_s },
        "/#{locale}/#{t('routes.shops')}/1/#{t('routes.products')}"
      )
      assert_recognizes(
        { controller: 'products', action: 'new', shop_id: '1', locale: locale.to_s },
        "/#{locale}/#{t('routes.shops')}/1/#{t('routes.products')}/#{t('routes.new')}"
      )
      assert_recognizes(
        { controller: 'products', action: 'edit', shop_id: '1', id: '2', locale: locale.to_s },
        "/#{locale}/#{t('routes.shops')}/1/#{t('routes.products')}/2/#{t('routes.edit')}"
      )

      subdomain = (locale == :en ? 'www' : locale.to_s)
      host = "#{subdomain}.example.com"
      assert_recognizes(
        { controller: 'pages', action: 'index', subdomain: subdomain },
        "http://#{host}"
      )
      assert_recognizes(
        { controller: 'pages', action: 'about', subdomain: subdomain },
        "http://#{host}/#{t('routes.about')}"
      )
      assert_recognizes(
        { controller: 'admin/pages', action: 'index', subdomain: subdomain },
        "http://#{host}/#{t('routes.admin')}"
      )
      assert_recognizes(
        { controller: 'admin/users', action: 'index', subdomain: subdomain },
        "http://#{host}/#{t('routes.admin')}/#{t('routes.users')}"
      )
      assert_recognizes(
        { controller: 'admin/users', action: 'new', subdomain: subdomain },
        "http://#{host}/#{t('routes.admin')}/#{t('routes.users')}/#{t('routes.new')}"
      )
      assert_recognizes(
        { controller: 'admin/users', action: 'edit', id: '1', subdomain: subdomain },
        "http://#{host}/#{t('routes.admin')}/#{t('routes.users')}/1/#{t('routes.edit')}"
      )
      assert_recognizes(
        { controller: 'shops', action: 'index', subdomain: subdomain },
        "http://#{host}/#{t('routes.shops')}"
      )
      assert_recognizes(
        { controller: 'shops', action: 'search', subdomain: subdomain },
        "http://#{host}/#{t('routes.shops')}/#{t('routes.search')}"
      )
      assert_recognizes(
        { controller: 'shops', action: 'new', subdomain: subdomain },
        "http://#{host}/#{t('routes.shops')}/#{t('routes.new')}"
      )
      assert_recognizes(
        { controller: 'shops', action: 'edit', id: '1', subdomain: subdomain },
        "http://#{host}/#{t('routes.shops')}/1/#{t('routes.edit')}"
      )
      assert_recognizes(
        { controller: 'shops', action: 'info', id: '1', subdomain: subdomain },
        "http://#{host}/#{t('routes.shops')}/1/#{t('routes.info')}"
      )
      assert_recognizes(
        { controller: 'products', action: 'index', shop_id: '1', subdomain: subdomain },
        "http://#{host}/#{t('routes.shops')}/1/#{t('routes.products')}"
      )
      assert_recognizes(
        { controller: 'products', action: 'new', shop_id: '1', subdomain: subdomain },
        "http://#{host}/#{t('routes.shops')}/1/#{t('routes.products')}/#{t('routes.new')}"
      )
      assert_recognizes(
        { controller: 'products', action: 'edit', shop_id: '1', id: '2', subdomain: subdomain },
        "http://#{host}/#{t('routes.shops')}/1/#{t('routes.products')}/2/#{t('routes.edit')}"
      )

      host = domain = "example.#{locale == :en ? 'com' : locale}"
      assert_recognizes(
        { controller: 'pages', action: 'index', domain: domain },
        "http://#{host}/"
      )
      assert_recognizes(
        { controller: 'pages', action: 'about', domain: domain },
        "http://#{host}/#{t('routes.about')}"
      )
      assert_recognizes(
        { controller: 'admin/pages', action: 'index', domain: domain },
        "http://#{host}/#{t('routes.admin')}"
      )
      assert_recognizes(
        { controller: 'admin/users', action: 'index', domain: domain },
        "http://#{host}/#{t('routes.admin')}/#{t('routes.users')}"
      )
      assert_recognizes(
        { controller: 'admin/users', action: 'new', domain: domain },
        "http://#{host}/#{t('routes.admin')}/#{t('routes.users')}/#{t('routes.new')}"
      )
      assert_recognizes(
        { controller: 'admin/users', action: 'edit', id: '1', domain: domain },
        "http://#{host}/#{t('routes.admin')}/#{t('routes.users')}/1/#{t('routes.edit')}"
      )
      assert_recognizes(
        { controller: 'shops', action: 'index', domain: domain },
        "http://#{host}/#{t('routes.shops')}"
      )
      assert_recognizes(
        { controller: 'shops', action: 'search', domain: domain },
        "http://#{host}/#{t('routes.shops')}/#{t('routes.search')}"
      )
      assert_recognizes(
        { controller: 'shops', action: 'new', domain: domain },
        "http://#{host}/#{t('routes.shops')}/#{t('routes.new')}"
      )
      assert_recognizes(
        { controller: 'shops', action: 'edit', id: '1', domain: domain },
        "http://#{host}/#{t('routes.shops')}/1/#{t('routes.edit')}"
      )
      assert_recognizes(
        { controller: 'shops', action: 'info', id: '1', domain: domain },
        "http://#{host}/#{t('routes.shops')}/1/#{t('routes.info')}"
      )
      assert_recognizes(
        { controller: 'products', action: 'index', shop_id: '1', domain: domain },
        "http://#{host}/#{t('routes.shops')}/1/#{t('routes.products')}"
      )
      assert_recognizes(
        { controller: 'products', action: 'new', shop_id: '1', domain: domain },
        "http://#{host}/#{t('routes.shops')}/1/#{t('routes.products')}/#{t('routes.new')}"
      )
      assert_recognizes(
        { controller: 'products', action: 'edit', shop_id: '1', id: '2', domain: domain },
        "http://#{host}/#{t('routes.shops')}/1/#{t('routes.products')}/2/#{t('routes.edit')}"
      )

    end
  end

end
