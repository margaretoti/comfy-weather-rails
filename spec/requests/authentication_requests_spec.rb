require 'rails_helper'

describe 'GET /auth/facebook/callback' do
  context 'with valid attributes' do
    before(:each) do
      OmniAuthTestHelper::valid_facebook_login_setup
      get '/auth/facebook/callback'
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
    end

    it 'should set user_id' do
      expect(session[:user_id]).to eq(User.last.id)
    end

    it 'should redirect to main page' do
      expect(response).to have_http_status :found
    end
  end

#test pending until figuring out how fb endpoints work
  context 'with invalid attributes' do
    xit 'should raise an exception' do
      OmniAuthTestHelper::cleanup
      OmniAuthTestHelper::invalid_facebook_login_setup
      get '/auth/facebook/callback'
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]

      expect { response }.to raise_exception
    end
  end
end

describe 'GET /auth/failure' do
  before(:each) do
    get '/auth/failure'
  end

  it 'should not set user_id' do
    expect(session[:user_id]).to eq(nil)
  end

  it 'should render a 301 http status code' do
    expect(response).to have_http_status :moved_permanently
  end
end
