[![Gem Version](https://badge.fury.io/rb/localizable_routes.svg)](http://badge.fury.io/rb/localizable_routes)
[![Code Climate](https://codeclimate.com/github/mmontossi/localizable_routes/badges/gpa.svg)](https://codeclimate.com/github/mmontossi/localizable_routes)
[![Build Status](https://travis-ci.org/mmontossi/localizable_routes.svg)](https://travis-ci.org/mmontossi/localizable_routes)
[![Dependency Status](https://gemnasium.com/mmontossi/localizable_routes.svg)](https://gemnasium.com/mmontossi/localizable_routes)

# Localizable Routes

Minimalistic toolkit to localize routes in rails.

## Install

Put this line in your Gemfile:
```ruby
gem 'localizable_routes'
```

Then bundle:
```
$ bundle
```

## Configuration

In your config/routes.rb use the localized method to decide wich routes will be localized:
```ruby
localized do
  get 'about' => 'pages#about'
end
```

Put your localizations inside the routes key in your locales yamls:
```yaml
es:
  routes:
    users: "usuarios"
    profile: "perfil"
    about: "nosotros"
```

NOTE: There is no need to put the full path, just localize each part individually.

## Usage

Helpers will continue working the same but I18n.locale will be use as default locale:
```ruby
about_path # Will output /en/about in case I18n.locale is :en
```

Here is an example of what you may want to add to your controllers to select the current locale:
```ruby
before_action :select_locale

protected

def select_locale
  I18n.locale = params[:locale]
end
```

## Credits

This gem is maintained and funded by [mmontossi](https://github.com/mmontossi).

## License

It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
