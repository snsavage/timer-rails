require 'jwt'

class Auth
  ALGORITHM = 'HS256'.freeze

  def self.issue(payload)
    JWT.encode(payload, auth_secret, ALGORITHM)
  end

  def self.decode(token)
    JWT.decode(token, auth_secret, true, algorithm: ALGORITHM).first
  end

  private_class_method

  def self.auth_secret
    Rails.application.secrets.secret_key_base
  end
end
