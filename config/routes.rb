Rails.application.routes.draw do
  root "static_pages#index"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace :admin do
    root "categories#index", as: "root"
    resources :users, only: :delete
    resources :categories
    resources :books
  end

  resources :users
  resources :books, only: :show
end
