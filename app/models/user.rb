class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable,  :omniauthable, :registerable, :confirmable, :recoverable, :validatable, :confirmable, :jwt_authenticatable, omniauth_providers: [:google_oauth2, :facebook], jwt_revocation_strategy: self
  before_create :generate_otp

  def generate_otp
    self.otp = SecureRandom.hex(3).to_i(16).to_s.rjust(6, '0')
    self.otp_sent_at = Time.now.utc
    self.otp_verified = false
  end

  def verify_otp(otp)
    return false if otp_verified || otp_expired?

    if self.otp == otp
      update(otp_verified: true)
      true
    else
      false
    end
  end

  before_save :set_default_active

  # Ensure the user is activated when both email and phone are verified
  def set_default_active
    self.active = false if self.active.nil?
  end

  def otp_expired?
    otp_sent_at < 1.minutes.ago
  end

  def otp_resend_allowed?
    otp_sent_at.nil? || otp_sent_at < 60.seconds.ago
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # Assuming the user model has a name

      # Uncomment the following line if using Devise's :confirmable module and
      # you want to skip confirmation for users signing in through OmniAuth providers
      # user.skip_confirmation!
    end
  end
end
