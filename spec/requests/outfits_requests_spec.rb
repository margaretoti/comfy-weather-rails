require 'rails_helper'

describe 'Outfits endpoints' do
  describe 'GET/outfits' do
    it 'returns JSON for outfits' do

      outfits = create_list(:outfit, 3)

      get(outfits_url, {}, accept_headers)

      expect(response).to have_http_status :ok
      expect(response.body).to have_json_size(3).at_path('outfits')
    end
  end

  describe 'POST/outfits' do
    it 'returns 200 status and the JSON for an outfit' do
      stub_weather_api_request
      weather_type = create(:weather_type)
      base64_string = Base64.encode64(File.open('spec/fixtures/image1.jpg', 'rb').read)
      user = create(:user)
      outfit_params = {
        outfit: {
          latitude: 42.36,
          longitude: -71.06,
          notes: "comfy",
          photo: "data:image/jpg;base64,#{base64_string}"
        }
      }
      post(outfits_url, outfit_params.to_json, authorization_headers(user))

      expect(response).to have_http_status :ok
      expect(response.body).to have_json_path('outfit/id')
      expect(response.body).to have_json_path('outfit/created_at')
      expect(response.body).to have_json_path('outfit/updated_at')
      expect(response.body).to have_json_path('outfit/latitude')
      expect(response.body).to have_json_path('outfit/longitude')
      expect(response.body).to have_json_path('outfit/photo_url')
      expect(response.body).to have_json_path('outfit/notes')
      expect(response.body).to have_json_path('outfit/is_public')
      expect(response.body).to have_json_path('outfit/outfit_weather_types/0/id')
      expect(response.body).to have_json_path('outfit/outfit_weather_types/0/created_at')
      expect(response.body).to have_json_path('outfit/outfit_weather_types/0/updated_at')
      expect(response.body).to have_json_path('outfit/outfit_weather_types/0/rating')
      expect(response.body).to have_json_path('outfit/outfit_weather_types/0/outfit_id')
      expect(response.body).to have_json_path('outfit/outfit_weather_types/0/weather_type_id')
      expect(response.body).to have_json_path('outfit/weather_types/0/id')
      expect(response.body).to have_json_path('outfit/weather_types/0/created_at')
      expect(response.body).to have_json_path('outfit/weather_types/0/updated_at')
      expect(response.body).to have_json_path('outfit/weather_types/0/temp_range')
      expect(response.body).to have_json_path('outfit/weather_types/0/precip_type')
    end
  end

  describe 'PUT /rating' do
    context 'add or update rating on the outfit with a certain weather type' do
      it 'sets the new rating' do
        user = create(:user)
        new_rating = 2
        outfit = create(:outfit_with_weather_types)
        params = { "rating": new_rating }
        outfit_weather_type_params = { id: outfit.id, "outfit_weather_type": params }

        put(rating_url, outfit_weather_type_params.to_json, authorization_headers(user))

        outfit.reload

        expect(outfit.outfit_weather_types.last.rating).to eq new_rating
      end
    end
  end
end
