# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token
  protect_from_forgery

  def google_oauth2
    handle_oauth("Google")
  end

  def facebook
    handle_oauth("Facebook")
  end

  private

  def handle_oauth(kind)
    auth = request.env['omniauth.auth']
    user = User.find_by(email: auth.info.email)
    if user.present?
      @user=user
    else
      @user = User.from_omniauth(request.env["omniauth.auth"])
    end
  
    
   

    if @user.persisted?
      sign_in(@user)
      set_flash_message(:notice, :success, kind: kind) if is_navigational_format?
      redirect_to after_sign_in_path_for(@user)
    else
      session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) 
      redirect_to new_user_registration_url
    end
  end
  def after_sign_in_path_for(resource)
    dashboard_path # Replace with the actual path to your dashboard
  end
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
