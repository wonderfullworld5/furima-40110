Rails.application.routes.draw do
  root 'items#index'
  devise_for :users

  resources :articles

  resources :items do
    #resources :purchases, only: [:new, :create, :edit,:update,:destroy]
  end
  #get '/items/new_user', to: 'items#new', as: 'new_user_item'
end

