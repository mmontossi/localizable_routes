[![Gem Version](https://badge.fury.io/rb/localizable_routes.svg)](http://badge.fury.io/rb/localizable_routes)
[![Code Climate](https://codeclimate.com/github/mmontossi/localizable_routes/badges/gpa.svg)](https://codeclimate.com/github/mmontossi/localizable_routes)
[![Build Status](https://travis-ci.org/mmontossi/localizable_routes.svg)](https://travis-ci.org/mmontossi/localizable_routes)
[![Dependency Status](https://gemnasium.com/mmontossi/localizable_routes.svg)](https://gemnasium.com/mmontossi/localizable_routes)

# Localizable Routes

Minimalistic toolkit to localize routes in rails.

## Why

I did this gem to:

- Being able to use different configurations on each set of routes.
- Having most common strategies available out of the box.
- Prevent bugs using not invasive code.

## Install

Put this line in your Gemfile:
```ruby
gem 'localizable_routes'
```

Then bundle:
```
$ bundle
```

## Usage

### Definitions

In your config/routes.rb use the localized method to decide wich routes will be localized:
```ruby
localized strategy: :param, locales: %i(es en) do
  get 'page' => 'pages#show', as: :param
end

localized strategy: :subdomain, locales: { 'es' => :es, 'www' => :en } do
  get 'page' => 'pages#show', as: :subdomain
end

localized strategy: :domain, locales: { 'domain.es' => :es, 'domain.com' => :en } do
  get 'page' => 'pages#show', as: :domain
end
```

### Localization

Put your localizations inside the routes key in your locales yamls:
```yaml
es:
  routes:
    page: "pagina"
```

NOTE: There is no need to put the full path, just localize each part individually.

### Urls

Url helpers will continue working the same:
```ruby
param_path
# => /en/pagina if I18n.locale is :es

subdomain_url
# => http://es.domain.com/pagina if current subdomain is es

domain_url
# => http://domain.es/pagina if current domain is domain.es
```

And you can change the locale by passing the corresponding parameter:
```ruby
param_path locale: :en
# => /en/page

subdomain_url sudomain: 'es'
# => http://es.domain.com/pagina

domain_url domain: 'domain.com'
# => http://domain.com/page
```

## Contributing

Any issue, pull request, comment of any kind is more than welcome!

I will mainly ensure compatibility to Rails, AWS, PostgreSQL, Redis, Elasticsearch and FreeBSD. 

## Credits

This gem is maintained and funded by [mmontossi](https://github.com/mmontossi).

## License

It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
