class Users::OtpVerificationsController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    # GET /otp_verifications/new
    def new
      @user = User.find_by(id: params[:user_id])
      if @user
        # Render the OTP verification form
        render :new
      else
        flash[:alert] = 'User not found'
        redirect_to root_path
      end
    end
  
    # POST /otp_verifications
    def create
      @user = User.find_by(id: params[:user_id])
      if @user&.verify_otp(params[:otp])
        @user.update(otp: nil, phone_verified: true)
        check_and_activate_user(@user)
        flash[:notice] = 'Phone number verified successfully.'
        redirect_to dashboard_path, notice: 'Welcome!' # Redirect to the desired path after successful verification
      else
        flash[:alert] = 'Invalid OTP. Please try again.'
        render :new
      end
    end

    def resend_otp
        @user = User.find_by(id: params[:user_id])
        if @user
          @user.generate_otp
          @user.save
          UserMailer.with(user: @user).phone_otp.deliver_now
          flash[:notice] = 'OTP has been resent to your phone number.'
          redirect_to new_otp_verification_path(user_id: @user.id)
        else
          flash[:alert] = 'User not found'
          redirect_to root_path
        end
    end
  
    private
  
    def check_and_activate_user(user)
      if user.email_verified && user.phone_verified
        user.update(active: true)
      end
    end
  end
  