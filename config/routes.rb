Rails.application.routes.draw do
  get 'comments/create'

  get 'comments/destroy'

  devise_for :users
  resources :posts, only: [:index, :create, :destroy]
  resources :comments, only: [:create, :destroy]

  root "posts#index"
end
