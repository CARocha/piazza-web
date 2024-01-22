class User < ApplicationRecord
  include Authentication
  before_validation :strip_extraneous_spaces
  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }
  validates :password_confirmation, presence: true

  has_many :memberships, dependent: :destroy
  has_many :organization, through: :memberships

  private

  def strip_extraneous_spaces
    self.name = name&.strip unless name.nil?
    self.email = email&.strip unless email.nil?
  end
end
