Rails.application.routes.draw do
  devise_for :users, controllers: {registrations:'users/registrations'}

  resources :friends
  
  root 'home#index'
  # root 'friends#index'
  
  #get 'home/index'
  get 'home/about'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  #get "home/userfriend"
  get "/userfriends", to: "home#userfriend"

end
