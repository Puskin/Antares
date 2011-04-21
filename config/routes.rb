Jetu::Application.routes.draw do

  resources :users
  resources :sessions, :only => [:new, :create, :destroy]
  resources :locations,:only => [:show, :create, :destroy]

  match '/signup',:to => 'users#new'
  match '/login', :to => 'sessions#new'
  match '/logout',:to => 'sessions#destroy'
  
  match '/about', :to => 'pages#about'
   
  root            :to => 'pages#home'

end
