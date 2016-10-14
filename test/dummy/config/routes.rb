Rails.application.routes.draw do

  concern :routes do
    root to: 'pages#index'
    namespace :namespace do
      get 'nested', to: 'pages#nested', as: :nested
      resources :resources
    end
    get 'simple', to: 'pages#simple', as: :simple
    get 'complex/:p1/:p2', to: 'pages#complex', as: :complex
    resources :resources do
      member do
        get 'member'
      end
      collection do
        get 'collection'
      end
      resources :nesteds
    end
  end

  localization strategy: :param, locales: %i(es en) do
    scope as: :param do
      concerns :routes
    end
  end

  localization strategy: :subdomain, locales: { 'es' => :es, 'en' => :en } do
    scope as: :subdomain do
      concerns :routes
    end
  end

  localization strategy: :domain, locales: { 'test.es' => :es, 'test.en' => :en } do
    scope as: :domain do
      concerns :routes
    end
  end

end
