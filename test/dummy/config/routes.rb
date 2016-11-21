Rails.application.routes.draw do

  concern :routes do
    root to: 'pages#index'
    get 'simple', to: 'pages#simple', as: :simple
    get 'complex/:p1/:p2', to: 'pages#complex', as: :complex
    namespace :namespace do
      get 'nested', to: 'pages#nested', as: :nested
      resources :resources
    end
    resources :resources do
      member do
        get 'member'
      end
      collection do
        get 'collection'
      end
      resources :nested
    end
  end

  localized strategy: :param, locales: %i(es en) do
    scope as: :param do
      concerns :routes
    end
  end

  localized strategy: :subdomain, locales: { 'es' => :es, 'en' => :en } do
    scope as: :subdomain do
      concerns :routes
    end
  end

  localized strategy: :domain, locales: { 'test.es' => :es, 'test.en' => :en } do
    scope as: :domain do
      concerns :routes
    end
  end

end
