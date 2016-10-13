Rails.application.routes.draw do
  root "static_pages#index"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace :admin do
    root "categories#index", as: "root"
    resources :users, only: [:index, :destroy]
    resources :categories
    resources :tags
    resources :books
    resources :reviews, only: [:index, :destroy]
    resources :comments, only: [:index, :destroy]
    resources :requests, except: :new
  end
  resources :activities, only: [:create, :destroy]
  resources :users do
    resources :following, only: [:index]
    resources :followers, only: [:index]
  end
  resources :relationships, only: [:create, :destroy]
  resources :books, only: :show do
    resources :reviews, except: [:show, :new] do
      resources :comments
    end
  end
end
