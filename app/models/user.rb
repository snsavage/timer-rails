# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  first_name      :string
#

class User < ApplicationRecord
  has_secure_password

  has_many :routines

  validates :email, uniqueness: true
  validates :email, :first_name, presence: true

  def jwt_payload
    { id: id, email: email, first_name: first_name }
  end
end
