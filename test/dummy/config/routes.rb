Rails.application.routes.draw do

  concern :routes do
    root to: 'pages#index'
    get 'about', to: 'pages#about'
    namespace :admin do
      root to: 'pages#index', as: ''
      resources :users
    end
    resources :shops do
      member do
        get 'info'
      end
      collection do
        get 'search'
      end
      resources :products
    end
  end

  localized strategy: :param, locales: %i(es en) do
    concerns :routes
  end

  localized strategy: :subdomain, locales: { 'es' => :es, 'www' => :en } do
    scope as: :subdomain do
      concerns :routes
    end
  end

  localized strategy: :domain, locales: { 'example.es' => :es, 'example.com' => :en } do
    scope as: :domain do
      concerns :routes
    end
  end

end
