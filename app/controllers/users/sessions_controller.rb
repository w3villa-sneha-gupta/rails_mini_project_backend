# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  def create
    self.resource = warden.authenticate!(auth_options)
    
    if resource.email_verified && resource.phone_verified
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      redirect_to dashboard_path, notice: 'Signed in successfully.'

    else
      flash[:alert] = 'User not activated. Please verify your account.'
      redirect_to new_user_session_path
    end
  end


  
  
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
