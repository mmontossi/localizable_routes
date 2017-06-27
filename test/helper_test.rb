require 'test_helper'

class HelperTest < ActionDispatch::IntegrationTest
  include I18nSupport

  test 'methods' do
    iterate_locales do |locale|

      assert_equal(
        "/#{locale}",
        root_path(locale: locale)
      )
      assert_equal(
        "/#{locale}/#{t('routes.about')}",
        about_path(locale: locale)
      )
      assert_equal(
        "/#{locale}/#{t('routes.admin')}",
        admin_path(locale: locale)
      )
      assert_equal(
        "/#{locale}/#{t('routes.admin')}/#{t('routes.users')}",
        admin_users_path(locale: locale)
      )
      assert_equal(
        "/#{locale}/#{t('routes.admin')}/#{t('routes.users')}/#{t('routes.new')}",
        new_admin_user_path(locale: locale)
      )
      assert_equal(
        "/#{locale}/#{t('routes.admin')}/#{t('routes.users')}/1/#{t('routes.edit')}",
        edit_admin_user_path(1, locale: locale)
      )
      assert_equal(
        "/#{locale}/#{t('routes.shops')}",
        shops_path(locale: locale)
      )
      assert_equal(
        "/#{locale}/#{t('routes.shops')}/#{t('routes.search')}",
        search_shops_path(locale: locale)
      )
      assert_equal(
        "/#{locale}/#{t('routes.shops')}/#{t('routes.new')}",
        new_shop_path(locale: locale)
      )
      assert_equal(
        "/#{locale}/#{t('routes.shops')}/1/#{t('routes.edit')}",
        edit_shop_path(1, locale: locale)
      )
      assert_equal(
        "/#{locale}/#{t('routes.shops')}/1/#{t('routes.info')}",
        info_shop_path(1, locale: locale)
      )
      assert_equal(
        "/#{locale}/#{t('routes.shops')}/1/#{t('routes.products')}",
        shop_products_path(1, locale: locale)
      )
      assert_equal(
        "/#{locale}/#{t('routes.shops')}/1/#{t('routes.products')}/#{t('routes.new')}",
        new_shop_product_path(1, locale: locale)
      )
      assert_equal(
        "/#{locale}/#{t('routes.shops')}/1/#{t('routes.products')}/2/#{t('routes.edit')}",
        edit_shop_product_path(1, 2, locale: locale)
      )

      subdomain = (locale == :en ? 'www' : locale.to_s)
      host = "#{subdomain}.example.com"
      assert_equal(
        "http://#{host}/",
        subdomain_root_url(subdomain: subdomain)
      )
      assert_equal(
        "http://#{host}/#{t('routes.about')}",
        subdomain_about_url(subdomain: subdomain)
      )
      assert_equal(
        "http://#{host}/#{t('routes.admin')}",
        subdomain_admin_url(subdomain: subdomain)
      )
      assert_equal(
        "http://#{host}/#{t('routes.admin')}/#{t('routes.users')}",
        subdomain_admin_users_url(subdomain: subdomain)
      )
      assert_equal(
        "http://#{host}/#{t('routes.admin')}/#{t('routes.users')}/#{t('routes.new')}",
        new_subdomain_admin_user_url(subdomain: subdomain)
      )
      assert_equal(
        "http://#{host}/#{t('routes.admin')}/#{t('routes.users')}/1/#{t('routes.edit')}",
        edit_subdomain_admin_user_url(1, subdomain: subdomain)
      )
      assert_equal(
        "http://#{host}/#{t('routes.shops')}",
        subdomain_shops_url(subdomain: subdomain)
      )
      assert_equal(
        "http://#{host}/#{t('routes.shops')}/#{t('routes.search')}",
        search_subdomain_shops_url(subdomain: subdomain)
      )
      assert_equal(
        "http://#{host}/#{t('routes.shops')}/#{t('routes.new')}",
        new_subdomain_shop_url(subdomain: subdomain)
      )
      assert_equal(
        "http://#{host}/#{t('routes.shops')}/1/#{t('routes.edit')}",
        edit_subdomain_shop_url(1, subdomain: subdomain)
      )
      assert_equal(
        "http://#{host}/#{t('routes.shops')}/1/#{t('routes.info')}",
        info_subdomain_shop_url(1, subdomain: subdomain)
      )
      assert_equal(
        "http://#{host}/#{t('routes.shops')}/1/#{t('routes.products')}",
        subdomain_shop_products_url(1, subdomain: subdomain)
      )
      assert_equal(
        "http://#{host}/#{t('routes.shops')}/1/#{t('routes.products')}/#{t('routes.new')}",
        new_subdomain_shop_product_url(1, subdomain: subdomain)
      )
      assert_equal(
        "http://#{host}/#{t('routes.shops')}/1/#{t('routes.products')}/2/#{t('routes.edit')}",
        edit_subdomain_shop_product_url(1, 2, subdomain: subdomain)
      )

      host = domain = "example.#{locale == :en ? 'com' : locale}"
      host = "www.#{domain}"
      assert_equal(
        "http://#{host}/",
        domain_root_url(domain: domain)
      )
      assert_equal(
        "http://#{host}/#{t('routes.about')}",
        domain_about_url(domain: domain)
      )
      assert_equal(
        "http://#{host}/#{t('routes.admin')}",
        domain_admin_url(domain: domain)
      )
      assert_equal(
        "http://#{host}/#{t('routes.admin')}/#{t('routes.users')}",
        domain_admin_users_url(domain: domain)
      )
      assert_equal(
        "http://#{host}/#{t('routes.admin')}/#{t('routes.users')}/#{t('routes.new')}",
        new_domain_admin_user_url(domain: domain)
      )
      assert_equal(
        "http://#{host}/#{t('routes.admin')}/#{t('routes.users')}/1/#{t('routes.edit')}",
        edit_domain_admin_user_url(1, domain: domain)
      )
      assert_equal(
        "http://#{host}/#{t('routes.shops')}",
        domain_shops_url(domain: domain)
      )
      assert_equal(
        "http://#{host}/#{t('routes.shops')}/#{t('routes.search')}",
        search_domain_shops_url(domain: domain)
      )
      assert_equal(
        "http://#{host}/#{t('routes.shops')}/#{t('routes.new')}",
        new_domain_shop_url(domain: domain)
      )
      assert_equal(
        "http://#{host}/#{t('routes.shops')}/1/#{t('routes.edit')}",
        edit_domain_shop_url(1, domain: domain)
      )
      assert_equal(
        "http://#{host}/#{t('routes.shops')}/1/#{t('routes.info')}",
        info_domain_shop_url(1, domain: domain)
      )
      assert_equal(
        "http://#{host}/#{t('routes.shops')}/1/#{t('routes.products')}",
        domain_shop_products_url(1, domain: domain)
      )
      assert_equal(
        "http://#{host}/#{t('routes.shops')}/1/#{t('routes.products')}/#{t('routes.new')}",
        new_domain_shop_product_url(1, domain: domain)
      )
      assert_equal(
        "http://#{host}/#{t('routes.shops')}/1/#{t('routes.products')}/2/#{t('routes.edit')}",
        edit_domain_shop_product_url(1, 2, domain: domain)
      )

    end
  end

end
