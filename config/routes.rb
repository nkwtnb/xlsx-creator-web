Rails.application.routes.draw do
  # Web
  root to: "home#new"
  get "/sign_in", to: "sessions#new"
  post "/sign_in", to: "sessions#create"
  post "/", to: "home#create"
  put "/", to: "home#put"
  delete "/", to: "home#delete"
  # put "/", to: "home#download"

  # API
  namespace :api do
    namespace :v1 do
      post "/form", to: "form#new"
    end
  end
end
