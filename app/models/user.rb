class User < ApplicationRecord
  before_validation :strip_extraneous_spaces
  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }

  has_many :memberships, dependent: :destroy
  has_many :organization, through: :memberships

  has_secure_password
  validates :password, presence: true, length: { minimum: 8, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED }

  private
    def strip_extraneous_spaces
      self.name = self.name&.strip unless self.name.nil?
      self.email = self.email&.strip unless self.email.nil?
    end
end
