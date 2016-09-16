require 'rails_helper'

describe 'Users endpoints' do
  describe 'GET /users' do
    it 'returns JSON for users' do
      users = create_list(:user, 3)

      get(
        users_url,
        {},
        { 'Accept' => 'application/vnd.comfy-weather-server.com; version=1',
          'Content-Type' => 'application/json'
        }
      )

      expect(response).to have_http_status :ok
      expect(response.body).to have_json_size(3)#at_path('users')
    end
  end
end
