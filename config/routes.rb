Rails.application.routes.draw do
  devise_for :users
  resources :posts, only: [:index, :create, :destroy]
  
end
