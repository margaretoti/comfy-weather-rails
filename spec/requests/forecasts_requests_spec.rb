require 'rails_helper'
require 'spec_helper'

describe 'Forecasts endpoints' do
  describe 'POST /forecasts' do
    it 'returns JSON for morning forecast' do
      stub_weather_api_request

      params = {latitude: 42, longitude: -71, period: "morning"}.to_json

      post(forecasts_url, params, accept_headers)

      expect(response).to have_http_status :ok
      expect(response.body).to have_json_path('morning/temperature')
      expect(response.body).to have_json_path('morning/apparentTemperature')
      expect(response.body).to have_json_path('morning/humidity')
      expect(response.body).to have_json_path('morning/windSpeed')
    end

    it 'returns JSON for afternoon forecast' do
      stub_weather_api_request

      params = {latitude: 42, longitude: -71, period: "afternoon"}.to_json

      post(forecasts_url, params, accept_headers)

      expect(response).to have_http_status :ok
      expect(response.body).to have_json_path('afternoon/temperature')
      expect(response.body).to have_json_path('afternoon/apparentTemperature')
      expect(response.body).to have_json_path('afternoon/humidity')
      expect(response.body).to have_json_path('afternoon/windSpeed')
    end

    it 'returns JSON for evening forecast' do
      stub_weather_api_request

      params = {latitude: 42, longitude: -71, period: "evening"}.to_json

      post(forecasts_url, params, accept_headers)

      expect(response).to have_http_status :ok
      expect(response.body).to have_json_path('evening/temperature')
      expect(response.body).to have_json_path('evening/apparentTemperature')
      expect(response.body).to have_json_path('evening/humidity')
      expect(response.body).to have_json_path('evening/windSpeed')
    end

    it 'returns JSON for all three periods\' forecast if no period param provided' do
      stub_weather_api_request

      post(
        forecasts_url,
        {latitude: 42, longitude: -71}.to_json,
        accept_headers
      )

      expect(response).to have_http_status :ok
      expect(response.body).to have_json_path('morning/temperature')
      expect(response.body).to have_json_path('afternoon/apparentTemperature')
      expect(response.body).to have_json_path('evening/humidity')
    end
  end
end