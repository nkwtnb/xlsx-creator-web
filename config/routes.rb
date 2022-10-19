Rails.application.routes.draw do
  # Web
  root to: "home#new"
  get "/sign_in", to: "sessions#new"
  post "/sign_in", to: "sessions#create"
  post "/sign_out", to: "sessions#delete"
  get "/sign_up", to: "sign_up#new"
  post "/sign_up", to: "sign_up#create"
  get "/mail", to: "mail#new"
  post "/mail", to: "mail#create"
  get '/usage', to: "usage#new"
  get '/terms', to: "terms#new"
  scope :form do
    post :create, to: "form#create"
    post :update, to: "form#update"
    delete :delete, to: "form#delete"
  end
  resources :password_resets, only: %i[new create edit update]

  # put "/", to: "home#download"

  # API
  namespace :api do
    namespace :v1 do
      post "/form", to: "form#new"
    end
  end
end
