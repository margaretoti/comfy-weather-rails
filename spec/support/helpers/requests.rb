module Helpers
  module Requests
    def accept_header
<<<<<<< HEAD
      'application/vnd.comfy-weather-server.com; version=1'
    end
    def accept_headers
      { 'Accept' => accept_header,
        'Content-Type' => 'application/json' }
    end
  end
=======
      "application/vnd.comfy-weather-server.com; version=1"
    end

    def accept_headers
      { 'Accept' => accept_header,
        'Content-Type' => 'application/json' }
   end
 end
>>>>>>> ab21822... cleaned up outfit model, routes, factories directory, outfit request specs, and placed dependencies in rails_helper.rb
end
