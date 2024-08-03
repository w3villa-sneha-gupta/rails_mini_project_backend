class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :recoverable,  :confirmable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

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
    otp_sent_at < 5.minutes.ago
  end
end
