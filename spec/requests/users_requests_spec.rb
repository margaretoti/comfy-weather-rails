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

  describe 'POST /users' do
    it 'With a valid access token' do
      stub_valid_facebook_me_request
      stub_facebook_me_picture_request

      post(users_url, {access_token: ''}.to_json, accept_headers)

      expect(User.count).to eq 1
      expect have_http_status :created
    end

    it 'with an invalid access token' do
      stub_invalid_facebook_me_request
      stub_facebook_me_picture_request

      post(users_url, {access_token: ''}.to_json, accept_headers)

      expect(User.count).to eq 0
      expect have_http_status :bad_request
    end
  end
end
