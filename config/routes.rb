Jetu::Application.routes.draw do
   
  resources :sessions, :only => [:new, :create, :destroy]
  resources :locations,:only => [:show, :create, :destroy]
  resources :connections  
  resources :users do
    resources :connections
  end
     
  root :to => 'pages#home' 

  match '/signup',:to => 'users#new'
  match '/login', :to => 'sessions#new'
  match '/logout',:to => 'sessions#destroy'
  match '/about', :to => 'pages#about'
  match '/home',  :to => 'pages#home'
   
end
