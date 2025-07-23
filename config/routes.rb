Rails.application.routes.draw do
  resources :tags
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  root "welcome#index"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :products do
    resources :comments, only: [ :create ]
    member do
      post "add_to_favorite"
      delete "delete_from_favorite"
    end
  end

  get "/favorites", to: "favorites#index"

  get "cart", to: "cart#show"
  post "cart/add", to: "cart#add"
  delete "cart/remove/:id", to: "cart#remove", as: "cart_remove"
  post "checkout/create", to: "checkout#create"
end
