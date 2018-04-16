Rails.application.routes.draw do
  resources :trips, only: %i[index show]
  resources :conditions, only: %i[index show]
  resources :stations, only: %i[index show], param: :slug

  resources :items, only: [:show]

  root "welcome#index"

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/bike-shop', to: 'shop#index'
  get '/cart', to: 'carts#show'
  post '/cart', to: 'carts#create'
  patch '/cart', to: 'carts#update'
  put '/cart', to: 'carts#update'
  delete '/cart', to: 'carts#destroy'

  resources :users, only: %i[new create show], shallow: true do
    resources :orders, only: %i[show create update]
  end

  get '/dashboard', to: 'dashboard#index'
  get '/trips-dashboard', to: 'trips#dashboard'

  namespace :admin do
    resources :trips, only: %i[edit update destroy new create]
    resources :conditions, only: %i[new create edit update destroy]
    resources :stations, only: %i[new create edit update destroy]
    get 'bikeshop/new', to: 'items#new'
    get '/dashboard', to: 'dashboard#index'
    get '/bike-shop', to: 'shop#index'
    post '/bike-shop', to: 'items#create'
    get '/bike-shop/:id/edit', to: 'items#edit'
    put '/bike-shop/:id/edit', to: 'items#update'
  end
end
