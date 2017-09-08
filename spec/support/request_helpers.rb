# https://github.com/alexfedoseev/isomorphic-comments-api/blob/master/spec/support/request_helpers.rb
module Requests
  module JsonHelpers
    def json
      @json ||= JSON.parse(response.body, symbolize_names: true)
    end

    def serialize(resource, options = {})
      ActiveModelSerializers::SerializableResource
        .new(resource, options)
        .serializable_hash
    end
  end

  module RequestHelpers
    def headers
      { "Content-Type" => "application/json" }
    end

    def auth_headers(user)
      headers.merge("Authorization" => "Bearer #{Auth.issue(user.jwt_payload)}")
    end

    def bad_auth_headers
      headers
    end
  end
end
