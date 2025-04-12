Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  get 'profiles/show'
  get 'profiles/edit'
  get 'profiles/update'
  get 'daily_questions/show'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :posts do
    resource :like, only: %i[create destroy]
  end
  resources :daily_questions, only: %i[index show]
  resource :profile, only: %i[show edit update]
  # 他のユーザーのプロフィール
  resources :profiles, only: [:show]

  get 'homes/top'
  root 'home#top'

  get 'up' => 'rails/health#show', as: :rails_health_check

  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest
end
