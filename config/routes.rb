Rails.application.routes.draw do
  root to: "home#new"
  get "/sign_in", to: "sessions#new"
  post "/sign_in", to: "sessions#create"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
