Rails.application.routes.draw do
  resources :memberships
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'breweries#index'
  get 'kaikki_bisset', to: 'beers#index'
  resources :ratings, only: [:index, :new, :create, :destroy]
  get 'signup', to: 'users#new'
  resource :session, only: [:new, :create, :destroy]
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  resources :memberships, only: [:index,:new, :create, :destroy]
  resources :places, only: [:index, :show]
  get 'places', to: 'places#index'
  post 'places', to:'places#search'
  get 'styles', to: 'styles#index'
  resources :styles, only: [:index, :show, :create, :destroy, :edit]
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  resources :users do
    post 'toggle_activity', on: :member
  end
  get 'beerlist', to:'beers#list'
  get 'brewerylist', to:'breweries#list'
  get 'auth/:provider/callback', to: 'sessions#create_oauth'
  resources :memberships do
    post 'toggle_confirmed', on: :member
  end
end

