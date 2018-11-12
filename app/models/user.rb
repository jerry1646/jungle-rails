
class User < ActiveRecord::Base

  has_many :comments
  has_secure_password

  validates :first_name,
      presence: true,
      length: { maximum: 50 }
  validates :last_name,
      presence: true,
      length: { maximum: 50 }
  validates :email,
      presence: true,
      format: { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}, length: { maximum:60 },
      uniqueness: true
  validates :password,
      presence: true,
      length: {minimum: 3}
  validates :password_confirmation,
      presence: true

  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email.strip.downcase)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end


end
