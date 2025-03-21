Rails.application.routes.draw do
  get "daily_questions/show"
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  resources :posts, only: %i[index new create]
  resources :daily_questions, only: [ :index, :show ]

  get "homes/top"
  root "home#top"

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
