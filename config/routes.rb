Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    registrations: 'users/registrations'
  }

  get 'otp/new', to: 'otps#new', as: :new_otp
  post 'otp/verify', to: 'otps#verify', as: :verify_otp
  post 'otp/resend', to: 'otps#resend', as: :resend_otp
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root 'home#index'

  # Defines the root path route ("/")
  # root "posts#index"
end
