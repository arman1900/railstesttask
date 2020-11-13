Rails.application.routes.draw do
  get 'password_resets/new'
  resources :users
  resources :posts
  resources :password_resets
  resources :comments
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"  
  delete "/logout", to: "sessions#destroy"
  root "pages#index" 

end
