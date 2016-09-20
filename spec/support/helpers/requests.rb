module Helpers
  module Requests
    def accept_header
      'application/vnd.comfy-weather-server.com; version=1'
    end

    def accept_headers
      { 'Accept' => accept_header,
        'Content-Type' => 'application/json' }
    end
  end
end
