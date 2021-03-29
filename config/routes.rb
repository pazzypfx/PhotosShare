Rails.application.routes.draw do
  get "login", to: "sessions#new", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"
  resources :sessions, only: %i[create destroy]

  scope :admin do
    resources :users, :photos, :products, :varieties, :places
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "gallery#index"
  get "gallery/show/:id", to: "gallery#show"
  get "gallery/new", to: 'gallery#new', as: 'gallery_new'
  post "gallery", to: "gallery#create"
  get "products/:code/varieties", to: "products#varieties"
end
