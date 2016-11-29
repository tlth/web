Rails.application.routes.draw do
  get 'sitemap.xml' => 'application#sitemap', format: :xml, as: :sitemap
  get 'robots.txt' => 'application#robots', format: :text, as: :robots

  root 'posts#index'
  devise_for :users
  resources  :users, except: :show

  concern :paginatable do
    get '(page/:page)', :action => :index, :on => :collection, :as => ''
  end

  get 'locale_sv', to: 'locale#locale_sv', as: 'swedish_locale'
  get 'locale_en', to: 'locale#locale_en', as: 'english_locale'
  get 'tweets', to: 'tweets#index'

  resources :tags, except: [:show]
  resources :posts, :concerns => :paginatable do
    get 'archive', on: :collection
  end

  resources :images, except: :show, :concerns => :paginatable do
    get 'search', on: :collection
  end

  resources :uploads, except: [:edit, :update], :concerns => :paginatable do
    get :search, on: :collection
  end

  resources :events do
    collection do
      get    'change_cover'
      post   'change_cover', to: 'events#change_cover_update', as: 'change_cover_update'
      delete 'delete_cover'
    end
  end

  resources :nav_items, except: [:index, :show] do
    member do
      get 'move_higher'
      get 'move_lower'
    end
    post :update_order, on: :collection
  end

  get  :settings, to: 'settings#edit'
  post :settings, to: 'settings#update'

  get    'pages', to: 'pages#index'
  get    ':id',   to: 'pages#show', as: :page
  patch  ':id',   to: 'pages#update'
  delete ':id',   to: 'pages#destroy'

  resources :pages, shallow: true, except: [:show, :delete, :index] do
    member do
      get    'add_user'
      post   'add_user',    action: :add_user_update
      delete 'remove_user', action: :remove_user
      get    'change_cover'
      delete 'delete_cover'
    end

    resources :contact_forms do
      post 'send_mail', on: :member
    end
  end
end
