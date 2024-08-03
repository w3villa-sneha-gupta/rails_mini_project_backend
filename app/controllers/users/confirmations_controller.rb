# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  # POST /resource/confirmation
  def create
    self.resource = resource_class.send_confirmation_instructions(resource_params)
    if successfully_sent?(resource)
      flash[:notice] = 'Confirmation instructions sent.'
      redirect_to new_user_session_path
    else
      flash[:alert] = resource.errors.full_messages.to_sentence
      redirect_to new_user_session_path
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    user = User.find_by(confirmation_token: params[:confirmation_token])

    if user.present? && user.confirmed_at.nil?
      user.update(email_verified: true, confirmed_at: Time.current)
      user.update(otp: SecureRandom.hex(3)) # Generate a 6-character OTP
      send_phone_otp(user)
      flash[:notice] = 'Email verified successfully. Please verify your phone number.'
      redirect_to new_users_otp_verification_path(user_id: user.id)
    else
      flash[:alert] = 'Invalid or expired confirmation token'
      redirect_to new_user_session_path
    end
  end

  private

  def send_phone_otp(user)
    if user.phone_number.present?
      client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
      client.messages.create(
        from: ENV['TWILIO_PHONE_NUMBER'],
        to: user.phone_number,
        body: "Your OTP for phone verification is #{user.otp}"
      )
    else
      raise "Phone number not provided."
    end
  end
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  # def show
  #   super
  # end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
end
