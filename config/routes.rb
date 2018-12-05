Rails.application.routes.draw do

  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  resources :sessions

  scope :admin do
    resources :users, :photos, :products, :varieties, :places
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'gallery#index'

  get 'gallery/show/:id', to: 'gallery#show'
  match '(/:name1(/:name2(/:name3)))', to: 'gallery#index', via: :get, as: :gallery

end
