require 'rails_helper'
require 'spec_helper'

describe 'Forecasts endpoints' do
  describe 'POST /forecasts' do
    it 'returns JSON for morning forecast' do
      stub_weather_api_request

      post(
        forecasts_url,
        {latitude: 42, longitude: -71, period: "morning"}.to_json,
        accept_headers
      )

      expect(response).to have_http_status :ok
      expect(response.body).to have_json_path('morning_forecast')
      expect(response.body).to have_json_path('morning_forecast/temperature')
      expect(response.body).to have_json_path('morning_forecast/apparentTemperature')
      expect(response.body).to have_json_path('morning_forecast/humidity')
      expect(response.body).to have_json_path('morning_forecast/windSpeed')
    end
  end
end
