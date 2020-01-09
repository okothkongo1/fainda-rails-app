class User < ApplicationRecord
  PASSWORD_REGEX = /\A (?=.{8,}) (?=.*\d) (?=.*[a-z]) (?=.*[A-Z])(?=.*[[:^alnum:]])/x.freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { maximum: 30 }
  validates :password_confirmation, presence: true

  validate :password_complexity

  def password_complexity
    return if password.blank?

    unless password =~ PASSWORD_REGEX
      errors.delete(:password)
      errors.add :password, 'Complexity requirement not met. Length should be at least 8 characters and include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
    end
end
end
