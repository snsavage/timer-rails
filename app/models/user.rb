class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true
  validates :email, :first_name, presence: true
end
