class User < ApplicationRecord
  before_validation :strip_extraneous_spaces
  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }
  validates :password_confirmation, presence: true

  has_many :memberships, dependent: :destroy
  has_many :organization, through: :memberships
  has_many :app_sessions

  has_secure_password
  validates :password, presence: true, length: { minimum: 8, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED }

  def self.create_app_session(email:, password:)
    return nil unless user = User.find_by(email: email.downcase)

    user.app_sessions.create if user.authenticate(password)
  end

  def authenticate_app_session(app_session_id, token)
    app_sessions.find(app_session_id).authenticate_token(token)
  rescue ActiveRecord::RecordNotFound
    nil
  end

  private

  def strip_extraneous_spaces
    self.name = name&.strip unless name.nil?
    self.email = email&.strip unless email.nil?
  end
end
