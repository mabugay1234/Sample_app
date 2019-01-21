class User < ApplicationRecord
  before_save :email_downcase
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length:
    {maximum: Settings.max_length_name}
  validates :email, presence: true, length:
    {maximum: Settings.max_length_email},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
