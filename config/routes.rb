Rails.application.routes.draw do
  get "profiles/show"
  get "profiles/edit"
  get "profiles/update"
  get "daily_questions/show"
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  resources :posts, only: %i[index new create show edit update destroy]
  resources :daily_questions, only: [ :index, :show ]
  resource :profile, only: [ :show, :edit, :update ]
  # 他のユーザーのプロフィール
  resources :profiles, only: [ :show ]


  get "homes/top"
  root "home#top"

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
