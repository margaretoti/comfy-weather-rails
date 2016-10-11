require 'rails_helper'

describe 'WeatherType endpoints' do
  describe 'GET/weather_types' do
    context 'show all weather_types' do
      it 'returns JSON for weather_types' do

        weather_types = create_list(:weather_type, 3)

        get(weather_types_url, {}, accept_headers)

        expect(response).to have_http_status :ok
        expect(response.body).to have_json_size(3).at_path('weather_types')
      end
    end
  end

  describe 'POST/weather_types/:id' do
    context 'create a new weather_type' do
      it 'returns 200 status and the JSON for an weather_type' do
        weather_type_params = { weather_type: { temp_low: 5, temp_high: 10, precip_type: "snow" } }

        post(weather_types_url, weather_type_params.to_json, accept_headers)

        expect(response).to have_http_status :ok
        expect(response.body).to have_json_path('weather_type/id')
        expect(response.body).to have_json_path('weather_type/created_at')
        expect(response.body).to have_json_path('weather_type/updated_at')
        expect(response.body).to have_json_path('weather_type/temp_range')
        expect(response.body).to have_json_path('weather_type/precip_type')
      end
    end
  end

  describe 'PATCH /weather_types/:id' do
    context 'change the precip type of weather_type' do
      it 'sets the new precip type' do
        old_precip_type = 'snow',
        new_precip_type = 'rain',
        weather_type = create(:weather_type, precip_type: old_precip_type)
        params = { precip_type: "rain" }
        weather_type_params = { weather_type: params}

        patch(weather_type_url(weather_type.id), weather_type_params.to_json, accept_headers)

        weather_type.reload

        expect(weather_type.precip_type).to eq new_precip_type
      end
    end
  end
end
