require 'test_helper'

class HelpersTest < ActionView::TestCase
  include Rails.application.routes.url_helpers, I18nSupport

  test 'methods' do
    iterate_locales do |locale|

      assert_equal(
        "/#{locale}/#{t('routes.namespace')}/#{t('routes.nested')}",
        param_namespace_nested_path(locale: locale)
      )
      assert_equal(
        "/#{locale}/#{t('routes.namespace')}/#{t('routes.resources')}",
        param_namespace_resources_path(locale: locale)
      )
      assert_equal(
        "/#{locale}/#{t('routes.namespace')}/#{t('routes.resources')}/#{t('routes.new')}",
        new_param_namespace_resource_path(locale: locale)
      )
      assert_equal(
        "/#{locale}/#{t('routes.namespace')}/#{t('routes.resources')}/10/#{t('routes.edit')}",
        edit_param_namespace_resource_path(10, locale: locale)
      )
      assert_equal(
        "/#{locale}/#{t('routes.simple')}",
        param_simple_path(locale: locale)
      )
      assert_equal(
        "/#{locale}/complex/1/2",
        param_complex_path(1, 2, locale: locale)
      )
      assert_equal(
        "/#{locale}/#{t('routes.resources')}",
        param_resources_path(locale: locale)
      )
      assert_equal(
        "/#{locale}/#{t('routes.resources')}/#{t('routes.collection')}",
        collection_param_resources_path(locale: locale)
      )
      assert_equal(
        "/#{locale}/#{t('routes.resources')}/#{t('routes.new')}",
        new_param_resource_path(locale: locale)
      )
      assert_equal(
        "/#{locale}/#{t('routes.resources')}/10/#{t('routes.edit')}",
        edit_param_resource_path(10, locale: locale)
      )
      assert_equal(
        "/#{locale}/#{t('routes.resources')}/10/#{t('routes.member')}",
        member_param_resource_path(10, locale: locale)
      )
      assert_equal(
        "/#{locale}/#{t('routes.resources')}/10/#{t('routes.nested')}",
        param_resource_nested_index_path(10, locale: locale)
      )
      assert_equal(
        "/#{locale}/#{t('routes.resources')}/10/#{t('routes.nested')}/#{t('routes.new')}",
        new_param_resource_nested_path(10, locale: locale)
      )
      assert_equal(
        "/#{locale}/#{t('routes.resources')}/10/#{t('routes.nested')}/4/#{t('routes.edit')}",
        edit_param_resource_nested_path(10, 4, locale: locale)
      )

      assert_equal(
        "http://#{locale}.test.host/#{t('routes.namespace')}/#{t('routes.nested')}",
        subdomain_namespace_nested_url(subdomain: locale)
      )
      assert_equal(
        "http://#{locale}.test.host/#{t('routes.namespace')}/#{t('routes.resources')}",
        subdomain_namespace_resources_url(subdomain: locale)
      )
      assert_equal(
        "http://#{locale}.test.host/#{t('routes.namespace')}/#{t('routes.resources')}/#{t('routes.new')}",
        new_subdomain_namespace_resource_url(subdomain: locale)
      )
      assert_equal(
        "http://#{locale}.test.host/#{t('routes.namespace')}/#{t('routes.resources')}/10/#{t('routes.edit')}",
        edit_subdomain_namespace_resource_url(10, subdomain: locale)
      )
      assert_equal(
        "http://#{locale}.test.host/#{t('routes.simple')}",
        subdomain_simple_url(subdomain: locale)
      )
      assert_equal(
        "http://#{locale}.test.host/complex/1/2",
        subdomain_complex_url(1, 2, subdomain: locale)
      )
      assert_equal(
        "http://#{locale}.test.host/#{t('routes.resources')}",
        subdomain_resources_url(subdomain: locale)
      )
      assert_equal(
        "http://#{locale}.test.host/#{t('routes.resources')}/#{t('routes.collection')}",
        collection_subdomain_resources_url(subdomain: locale)
      )
      assert_equal(
        "http://#{locale}.test.host/#{t('routes.resources')}/#{t('routes.new')}",
        new_subdomain_resource_url(subdomain: locale)
      )
      assert_equal(
        "http://#{locale}.test.host/#{t('routes.resources')}/10/#{t('routes.edit')}",
        edit_subdomain_resource_url(10, subdomain: locale)
      )
      assert_equal(
        "http://#{locale}.test.host/#{t('routes.resources')}/10/#{t('routes.member')}",
        member_subdomain_resource_url(10, subdomain: locale)
      )
      assert_equal(
        "http://#{locale}.test.host/#{t('routes.resources')}/10/#{t('routes.nested')}",
        subdomain_resource_nested_index_url(10, subdomain: locale)
      )
      assert_equal(
        "http://#{locale}.test.host/#{t('routes.resources')}/10/#{t('routes.nested')}/#{t('routes.new')}",
        new_subdomain_resource_nested_url(10, subdomain: locale)
      )
      assert_equal(
        "http://#{locale}.test.host/#{t('routes.resources')}/10/#{t('routes.nested')}/4/#{t('routes.edit')}",
        edit_subdomain_resource_nested_url(10, 4, subdomain: locale)
      )

      domain = "test.#{locale}"
      assert_equal(
        "http://#{domain}/#{t('routes.namespace')}/#{t('routes.nested')}",
        domain_namespace_nested_url(domain: domain)
      )
      assert_equal(
        "http://#{domain}/#{t('routes.namespace')}/#{t('routes.resources')}",
        domain_namespace_resources_url(domain: domain)
      )
      assert_equal(
        "http://#{domain}/#{t('routes.namespace')}/#{t('routes.resources')}/#{t('routes.new')}",
        new_domain_namespace_resource_url(domain: domain)
      )
      assert_equal(
        "http://#{domain}/#{t('routes.namespace')}/#{t('routes.resources')}/10/#{t('routes.edit')}",
        edit_domain_namespace_resource_url(10, domain: domain)
      )
      assert_equal(
        "http://#{domain}/#{t('routes.simple')}",
        domain_simple_url(domain: domain)
      )
      assert_equal(
        "http://#{domain}/complex/1/2",
        domain_complex_url(1, 2, domain: domain)
      )
      assert_equal(
        "http://#{domain}/#{t('routes.resources')}",
        domain_resources_url(domain: domain)
      )
      assert_equal(
        "http://#{domain}/#{t('routes.resources')}/#{t('routes.collection')}",
        collection_domain_resources_url(domain: domain)
      )
      assert_equal(
        "http://#{domain}/#{t('routes.resources')}/#{t('routes.new')}",
        new_domain_resource_url(domain: domain)
      )
      assert_equal(
        "http://#{domain}/#{t('routes.resources')}/10/#{t('routes.edit')}",
        edit_domain_resource_url(10, domain: domain)
      )
      assert_equal(
        "http://#{domain}/#{t('routes.resources')}/10/#{t('routes.member')}",
        member_domain_resource_url(10, domain: domain)
      )
      assert_equal(
        "http://#{domain}/#{t('routes.resources')}/10/#{t('routes.nested')}",
        domain_resource_nested_index_url(10, domain: domain)
      )
      assert_equal(
        "http://#{domain}/#{t('routes.resources')}/10/#{t('routes.nested')}/#{t('routes.new')}",
        new_domain_resource_nested_url(10, domain: domain)
      )
      assert_equal(
        "http://#{domain}/#{t('routes.resources')}/10/#{t('routes.nested')}/4/#{t('routes.edit')}",
        edit_domain_resource_nested_url(10, 4, domain: domain)
      )

    end
  end

end
