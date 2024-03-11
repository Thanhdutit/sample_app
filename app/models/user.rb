class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save :downcase_email

  validates :name, presence: true,
            length: {maximum: Settings.digit_50}
  validates :email, presence: true,
            length: {maximum: Settings.digit_255},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: true

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end