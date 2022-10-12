Rails.application.routes.draw do
  # Web
  root to: "home#new"
  get "/sign_in", to: "sessions#new"
  post "/sign_in", to: "sessions#create"
  post "/", to: "home#create"
  put "/", to: "home#put"
  delete "/", to: "home#delete"
  scope :form do
    post :create, to: "form#create"
    post :update, to: "form#update"
    delete :delete, to: "form#delete"
  end

  # put "/", to: "home#download"

  # API
  namespace :api do
    namespace :v1 do
      post "/form", to: "form#new"
    end
  end
end
