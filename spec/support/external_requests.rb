module ExternalRequests
  def stub_facebook_me_request
      stub_request(:get, /https:\/\/graph.facebook.com\/me\?access_token=.*/).
        to_return(body: facebook_data)
  end

  def stub_valid_facebook_me_request
    stub_request(:get, /https:\/\/graph.facebook.com\/me\?access_token=.*/).
      to_return(body: facebook_data)
  end

  def stub_invalid_facebook_me_request
    stub_request(:get, /https:\/\/graph.facebook.com\/me\?access_token=.*/).
      to_return(body: invalid_oauth_response, status: 400)
  end

  def facebook_data
    {
      email: nil,
      gender: nil,
      preferred_time: nil,
      weather_perception: 1,
      provider: "facebook",
      uid: "131590030632288",
      name: "Harold Sipe",
      auth_token: "8184d823868ad97c68cff8bdca93dc3a0dcb3c9c",
      auth_expires_at: "2016-09-16 09:19:45",
      created_at: "2016-09-16 09:19:45",
      updated_at: "2016-09-16 09:19:45",
      id: "7a0ab043-fc5f-48bf-8120-e1519134c097",
      avatar_file_name: "Harold Sipe_avatar",
      avatar_content_type: "image/jpg",
      avatar_file_size: 1418,
      avatar_updated_at: "2016-09-16 09:19:45"
    }.to_json
  end

  def invalid_oauth_response
    { error:
      { message: 'Invalid OAuth access token.',
        type: 'OAuthException',
        code: 190 }
    }.to_json
  end
end
