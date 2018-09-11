Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  root to: 'dashboard#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  get '/logout', to: 'sessions#destroy'
  delete '/logout', to: 'sessions#destroy'

  get '/bike-shop', to: 'accessories#index'

  get 'admin/dashboard' => 'admin/base#dashboard'

  namespace :admin do
    resources :users
    resources :stations, only: [:index, :edit, :update, :destroy]
    resources :orders, only: [:index]
    resources :accessories, only: [:index]
  end

  resources :users, only: [:new, :create, :show]
  resources :stations, only: [:index]
  resources :trips, only: [:index, :show]
  resources :conditions, only: [:index, :show]
  resources :accessories, only: [:show]
  resources :carts, only: [:create]

  get '/:id', to: 'stations#show'

end
