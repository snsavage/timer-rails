class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true
  validates :email, :first_name, presence: true

  def jwt_payload
    {id: id, email: email, first_name: first_name}
  end
end
