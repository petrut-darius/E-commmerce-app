Rails.application.routes.draw do
  resources :products
  root "welcome#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  #
  resources :products do
    resources :comments, only: [ :create ]
    member do
      post "add_to_favorite"
      delete "delete_from_favorite"
    end
  end

  get "/favorites", to: "favorites#index"


  Rails.application.routes.draw do
    devise_for :users, controllers: {
      registrations: "users/registrations"
    }
  end

  get "cart", to: "cart#show"
  post "cart/add", to: "cart#add"
  post "cart/remove", to: "cart#remove"
  post "checkout/create", to: "checkout#create"
  get "checkout/success", to: "checkout#success"
  get "checkout/cancel", to: "checkout#cancel"
end
