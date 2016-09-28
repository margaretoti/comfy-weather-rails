module ExternalRequests
  def stub_facebook_me_request(identity = build_stubbed(:user))
    stub_request(:get, /https:\/\/graph.facebook.com\/me\?access_token=.*/).
      to_return(body: identity)
  end

  def stub_existing_facebook_me_request(identity)
    stub_request(:get, /https:\/\/graph.facebook.com\/me\?access_token=.*/).
      to_return(body: identity)
  end

  def stub_invalid_facebook_me_request(identity = build_stubbed(:user))
    stub_request(:get, "https://graph.facebook.com/me?access_token=#{identity.auth_token}").
      to_return(body: invalid_oauth_response, status: 400)
  end

  def invalid_oauth_response
    { error:
      { message: 'Invalid OAuth access token.',
        type: 'OAuthException',
        code: 190 }
    }.to_json
  end
end
