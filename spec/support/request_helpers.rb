# https://github.com/alexfedoseev/isomorphic-comments-api/blob/master/spec/support/request_helpers.rb
module Requests

  module JsonHelpers
    def json
      @json ||= JSON.parse(response.body, symbolize_names: true)
    end
  end

end
