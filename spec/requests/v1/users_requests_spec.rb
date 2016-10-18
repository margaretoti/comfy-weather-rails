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
    context 'with a valid access token' do
      it 'creates and returns a user' do
        stub_valid_facebook_me_request
        stub_facebook_me_picture_request
        post(users_url, {access_token: ''}.to_json, accept_headers)

        expect(User.count).to eq 1
        expect have_http_status :created
      end
    end

    context 'with an invalid access token' do
      it 'renders a bad request http status' do
        stub_invalid_facebook_me_request
        stub_facebook_me_picture_request

        post(users_url, {access_token: ''}.to_json, accept_headers)

        expect(User.count).to eq 0
        expect have_http_status :bad_request
      end
    end
  end

  describe 'PATCH /users/id' do
    context 'with valid attributes' do
      it 'returns JSON for a user' do
        current_user = create(:user)

        patch(user_url(current_user), user_attributes('test@gmail.com'), authorization_headers(current_user))

        current_user.reload

        expect(response).to have_http_status :ok
        expect(current_user.name).to eq parse_json(user_attributes('test@gmail.com'))['user']['name']
      end
    end
  end

  describe 'DELETE /signout' do
    it "sets user's token to be expired, and returns a 204 response" do
      current_user = create(:user)

      delete(
        signout_url,
        {},
        authorization_headers(current_user)
      )

      current_user.reload
      expect(response).to have_http_status :no_content
      expect(current_user.auth_expires_at < Time.current).to be true
    end
  end

  private

  def user_attributes(email)
    { user:
      {
          email: email,
          gender: 1,
          preferred_time: Time.current,
          weather_perception: 1,
          name: "MyString"
      }
    }.to_json
  end
end
