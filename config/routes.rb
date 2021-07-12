Rails.application.routes.draw do

  devise_for :users
  root "homes#top"
  get "home/about" => "homes#about"
  get "searches" => "searches#search"

  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end
  resources :books do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
end
