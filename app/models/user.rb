# frozen_string_literal: true

class User < ApplicationRecord
  before_save { self.email = email.downcase }

  EMAIL_REGEX = /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/.freeze
  PASSWORD_REGEX = /\A (?=.{8,}) (?=.*\d) (?=.*[a-z]) (?=.*[A-Z])(?=.*[[:^alnum:]])/x.freeze
  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { maximum: 30 }
  validates :password, presence: true, confirmation: true, format: { with: PASSWORD_REGEX,
                                                                     message: 'enter stronger password' }
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: { case_sensistive: false }, format: { with: EMAIL_REGEX }
  has_secure_password
end
