require 'rails_helper'
require 'spec_helper'

describe 'Users endpoints' do
  describe 'GET /users' do
    it 'returns JSON for users' do
      users = create_list(:user, 3)

      get(
        users_url,
        {},
        accept_headers
      )

      expect(response).to have_http_status :ok
      expect(response.body).to have_json_size(3).at_path('users')
    end
  end
end
