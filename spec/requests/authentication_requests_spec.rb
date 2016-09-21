require 'rails_helper'
require 'spec_helper'

#test suite for post access tokens, TBD
=begin
describe 'POST /auth/facebook' do

  context 'with valid attributes' do
    context 'such as a facebook token' do
      it 'returns JSON for an authentication' do
        post(authentications_url, access_token, accept_headers)

        expect(response).to have_http_status :ok
        expect(response).to match_response_schema(:authentication)
      end
    end
  end
end
=end

describe 'GET /auth/facebook/callback' do

  before(:each) do
    OmniAuthTestHelper::valid_facebook_login_setup
    get '/auth/facebook/callback'
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
  end

  it 'should set user_id' do
    expect(session[:user_id]).to eq(User.last.id)
  end

  it 'should redirect to root' do
    expect(response).to redirect_to root_path
  end
end

describe 'GET /auth/failure' do

  it 'should redirect to root' do
    get '/auth/failure'
    expect(response).to redirect_to root_path
  end
end
