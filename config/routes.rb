Jetu::Application.routes.draw do

  resources :users

  match '/signup',:to => 'users#new'
  match '/about', :to => 'pages#about'
   
  root            :to => 'pages#home'

end
