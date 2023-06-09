Rails.application.routes.draw do
  devise_for :users
  #get '/home', to: 'home#index'
  root 'home#index'

  # lets add some routes for our Users
  #resources :users, :only => [:index, :show, :destroy]
  #resources :users, except: [:new]

  resources :users, except: [:new] do
    member do
      delete :delete_avatar
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
