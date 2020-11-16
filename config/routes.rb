Rails.application.routes.draw do
  get 'password_resets/new'
  get '/users/invite/:id', to: "invitations#create"
  get '/invites', to: "invitations#index"
  patch '/invites/:id', to: "invitations#update"
  resources :users
  resources :posts
  resources :password_resets
  resources :comments
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"  
  delete "/logout", to: "sessions#destroy"
  root "pages#index" 

end
