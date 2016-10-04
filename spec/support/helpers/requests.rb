module Helpers
  module Requests
    def accept_header
      'application/vnd.comfy-weather-server.com; version=1'
    end

    def accept_headers
      { 'Accept' => accept_header,
        'Content-Type' => 'application/json' }
    end

    def token(user = nil)
      if user
        user.auth_token
      else
        create(:user).auth_token
      end
    end

    def authorization_header(user = nil)
      "Token token=#{token(user)}"
    end

    def authorization_headers(user = nil)
      accept_headers.merge('Authorization' => authorization_header(user))
    end
  end
end
