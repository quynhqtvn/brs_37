Rails.application.routes.draw do
  root "static_pages#index"

  resources :users
  resources :books do
    resources :reviews, only: [:show, :new, :create]
  end
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
    resources :books do
      resources :reviews, only: [:index, :destroy]
    end
    resources :reviews, only: :index
  end

  resources :users
  resources :books, only: :show
end
