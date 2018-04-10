Rails.application.routes.draw do
  resources :trips, only: %i[index show]
  resources :conditions, only: [:index]
end
