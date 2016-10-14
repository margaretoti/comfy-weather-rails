module ExternalRequests
  def stub_weather_api_request
    stub_request(:get, /https:\/\/api.darksky.net\/forecast\/8c47b7928f3919eb493c0d90dd9dd4dc\/42.36,-71.06,\d{10}/).
    with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
    to_return(status: 200, body: weather_data, headers: {})
  end

  def stub_facebook_me_request
    stub_request(:get, /https:\/\/graph.facebook.com\/me\?access_token=.*/).
    to_return(body: facebook_data)
  end

  def stub_facebook_me_picture_request
    stub_request(:get, /https:\/\/graph.facebook.com\/\d+\/picture/).
    to_return(status: 200, body: avatar_data, headers: {'Content-Type': 'image/jpeg'})
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
     latitude: 42.36,
     longitude: -71.06,
     offset: 6,
     currently:
     {
        time: 1475175917,
        summary: "Overcast",
        icon: "cloudy",
        nearestStormDistance: 33,
        nearestStormBearing: 161,
        precipIntensity: 0,
        precipProbability: 0,
        temperature: 58.91,
        apparentTemperature: 58.91,
        dewPoint: 51.49,
        humidity: 0.76,
        windSpeed: 10.74,
        windBearing: 38,
        visibility: 9.76,
        cloudCover: 0.98,
        pressure: 1030.95,
        ozone: 288.43
      },
     hourly:
     {
       data:
        [
          {},{},{},{},{},{},{},
          {time: 1475197200,
           summary: "Overcast",
           icon: "cloudy",
           precipIntensity: 0,
           precipProbability: 0,
           temperature: 54.67,
           apparentTemperature: 54.67,
           dewPoint: 50.87,
           humidity: 0.87,
           windSpeed: 10.5,
           windBearing: 39,
           visibility: 8.96,
           cloudCover: 0.98,
           pressure: 1031.83,
           ozone: 287.76
         },
         {},{},{},{},{},{},{},
         {
           time: 1475226000,
           summary: "Overcast",
           icon: "cloudy",
           precipIntensity: 0,
           precipProbability: 0,
           temperature: 53.7,
           apparentTemperature: 53.7,
           dewPoint: 49.7,
           humidity: 0.86,
           windSpeed: 10.42,
           windBearing: 42,
           visibility: 8.92,
           cloudCover: 1,
           pressure: 1030.77,
           ozone: 283.2
        },
        {},{},{},
        {
           time: 1475244000,
           summary: "Overcast",
           icon: "cloudy",
           precipIntensity: 0.0028,
           precipProbability: 0.07,
           precipType: "rain",
           temperature: 56.83,
           apparentTemperature: 56.83,
           dewPoint: 51.86,
           humidity: 0.83,
           windSpeed: 14.1,
           windBearing: 46,
           visibility: 9.82,
           cloudCover: 1,
           pressure: 1030.67,
           ozone: 279.42
        }
       ]
     },
     daily:
     {
       data:
       [
         {
          time: 1475640000,
          summary: "Partly cloudy until evening.",
          icon: "partly-cloudy-day",
          sunriseTime: 1475664414,
          sunsetTime: 1475705998,
          moonPhase: 0.14,
          precipIntensity: 0,
          precipIntensityMax: 0,
          precipProbability: 0,
          temperatureMin: 49.7,
          temperatureMinTime: 1475722800,
          temperatureMax: 62.39,
          temperatureMaxTime: 1475694000,
          apparentTemperatureMin: 48.84,
          apparentTemperatureMinTime: 1475722800,
          apparentTemperatureMax: 62.39,
          apparentTemperatureMaxTime: 1475694000,
          dewPoint: 49.84,
          humidity: 0.82,
          windSpeed: 8.26,
          windBearing: 15,
          visibility: 9.55,
          cloudCover: 0.54,
          pressure: 1026.54,
          ozone: 277.02
        }
       ]
     }
   }.to_json
  end

  def facebook_data
      {
        name: "Harold Sipe",
        picture:
        {
          data:
          {
            is_silhouette: false,
            url:
            "https://scontent.xx.fbcdn.net/v/t1.0-1/p50x50/14333796_" +
            "137721806685777_5915056444051503896_n.jpg?" +
            "oh=e502f2c18ef6721d65697b4b52bc8969&oe=58758B74"
          }
        },
        id: "131590030632288"
      }.to_json
  end

  def avatar_data
    {
      data:
      {
        is_silhouette: false,
        url:
        "https://scontent.xx.fbcdn.net/v/t1.0-1/p50x50/14333796_" +
        "137721806685777_5915056444051503896_n.jpg?" +
        "oh=e502f2c18ef6721d65697b4b52bc8969&oe=58758B74"
      }
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
