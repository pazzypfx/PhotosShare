Rails.application.routes.draw do
  root 'gallery#index'

  get 'gallery/index(/:name1(/:name2(/:name3)))', :to => 'gallery#index'
  get 'gallery/show/:id', :to => 'gallery#show'

  resources :photos
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
