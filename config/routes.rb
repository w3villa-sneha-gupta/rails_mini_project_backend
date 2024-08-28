Rails.application.routes.draw do
  get 'premium/buy'
  get 'dashboard/show'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks' 
  }

  get 'otp_verifications/new', to: 'users/otp_verifications#new', as: 'new_users_otp_verification'
  post 'otp_verifications', to: 'users/otp_verifications#create', as: 'users_otp_verifications'
  post 'otp_verifications/resend', to: 'users/otp_verifications#resend_otp', as: 'resend_otp'

  get 'dashboard', to: 'dashboard#show', as: :dashboard
  get 'buy_premium', to: 'premium#buy', as: 'buy_premium'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root 'home#index'
  resource :dashboard, only: [:show] # Dashboard route
  resource :users, only: [:update, :edit]    # Handle user updates
  # Defines the root path route ("/")
  # root "posts#index"
end
