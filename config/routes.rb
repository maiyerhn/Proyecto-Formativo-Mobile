Rails.application.routes.draw do
  resources :order_details
  resources :orders
  resources :products
  resources :users, only: [:index, :show, :update, :destroy]
  post 'signup', to: 'users#signup'
  post 'login', to: 'users#login'
  post 'logout', to: 'users#logout'
  post 'createproducto', to: 'products#create'

end
