module ExternalRequests
  def stub_weather_api_request
    stub_request(:get, "https://api.darksky.net/forecast/8c47b7928f3919eb493c0d90dd9dd4dc/42,-71").
    with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
    to_return(:status => 200, :body => weather_data, :headers => {})
  end

  def stub_facebook_me_request
    stub_request(:get, /https:\/\/graph.facebook.com\/me\?access_token=.*/).
    to_return(body: facebook_data)
  end

  def stub_facebook_me_picture_request
    stub_request(:get, "https://graph.facebook.com/7a0ab043-fc5f-48bf-8120-e1519134c097/picture").
    with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
    to_return(:status => 200, :body => "", :headers => {})
  end

  def stub_valid_facebook_me_request
    stub_request(:get, /https:\/\/graph.facebook.com\/me\?access_token=.*/).
    to_return(body: facebook_data)
  end

  def stub_invalid_facebook_me_request
    stub_request(:get, /https:\/\/graph.facebook.com\/me\?access_token=.*/).
    to_return(body: invalid_oauth_response, status: 400)
  end

  def weather_data
    {
     latitude: 42,
     longitude: 71,
     offset: 6,
     hourly:
     {
       data:
        [
          {},{},{},{},{},{},{},
          {time: 1475157331,
           summary: "Clear",
           icon: "clear-night",
           precipIntensity: 0.0016,
           precipProbability: 0.03,
           precipType: "rain",
           temperature: 41.93,
           apparentTemperature: 37.2,
           dewPoint: 16.78,
           humidity: 0.36,
           windSpeed: 7.49,
           windBearing: 190,
           cloudCover: 0.1,
           pressure: 1005.44,
           ozone: 270
         }
       ]
     }
   }.to_json
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
