
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
      format: { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}, length: { maximum:60 }
  validates :password_digest,
      presence: true

end
