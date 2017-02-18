Rails.application.routes.draw do

  resources :photos
  resources :users
  resources :products
  get 'varieties/:product', to: 'varieties#index'
  resources :varieties

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'gallery#index'

  get 'gallery/show/:id', to: 'gallery#show'
  match '(/:name1(/:name2(/:name3)))', to: 'gallery#index', via: :get
end
