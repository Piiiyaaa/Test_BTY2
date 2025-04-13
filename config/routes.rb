Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :posts do
    resource :like, only: %i[create destroy]
  end
  resources :daily_questions, only: %i[index show]
  # 自分のプロフィール
  resource :profile, only: %i[show edit update], controller: 'profiles'
  # 他のユーザーのプロフィール
  get 'profiles/:id', to: 'profiles#show', as: 'user_profile'
  
  resources :relationships, only: [:create, :destroy]

  get 'homes/top'
  root 'home#top'

  get 'up' => 'rails/health#show', as: :rails_health_check

  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest
end
