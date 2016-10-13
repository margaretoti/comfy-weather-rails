require 'rails_helper'

describe 'Outfits endpoints' do
  describe 'GET /outfits' do
    it 'returns JSON for outfits' do
      user = create(:user)
      outfits = create_list(:outfit, 3)

      get(outfits_url, {}, authorization_headers(user))

      expect(response).to have_http_status :ok
      expect(response.body).to have_json_size(3).at_path('outfits')
    end
  end

  describe 'POST /outfits' do
    context 'with valid outfit params' do
      it 'returns 200 status and the JSON for an outfit' do
        stub_weather_api_request

        weather_type = create(:weather_type)
        base64_string = Base64.encode64(File.open('spec/fixtures/image1.jpg', 'rb').read)

        user = create(:user)
        articles = create_list(:article_of_clothing, 3, user: user)

        outfit_params = {
          outfit: {
            latitude: 42.36,
            longitude: -71.06,
            notes: "comfy",
            photo: "data:image/jpg;base64,#{base64_string}"
          },
          article_of_clothings: articles.map(&:id)
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
        have_outfit_weather_types_json_path(response.body, 'outfit/outfit_weather_types/0')
        have_weather_types_json_path(response.body, 'outfit/weather_types/0')
      end
    end

    context 'with invalid outfit params (missing longitude)' do
      it 'returns 400 status' do
        weather_type = create(:weather_type)
        base64_string = Base64.encode64(File.open('spec/fixtures/image1.jpg', 'rb').read)

        user = create(:user)
        articles = create_list(:article_of_clothing, 3, user: user)

        outfit_params = {
          outfit: {
            latitude: 42.36,
            notes: "chilly",
            photo: "data:image/jpg;base64,#{base64_string}"
          },
          article_of_clothings: articles.map(&:id)
        }

        post(outfits_url, outfit_params.to_json, authorization_headers(user))

        expect(Outfit.count).to eq 0
        expect(response).to have_http_status :bad_request
      end
    end
  end

  describe 'PATCH /rating' do
    context 'with valid outfit weather type params' do
      it 'sets the new rating' do
        user = create(:user)
        outfit = create(:outfit_with_weather_types)
        new_rating = "toasty"
        params = { 'rating': new_rating }
        outfit_weather_type_params = { id: outfit.id, 'outfit_weather_type': params }

        patch(rating_url, outfit_weather_type_params.to_json, authorization_headers(user))

        outfit.reload

        expect(outfit.outfit_weather_types.last.rating).to eq new_rating
      end
    end

    context 'with invalid outfit weather type params' do
      it 'remains the old rating' do
        user = create(:user)
        outfit = create(:outfit_with_weather_types)
        old_rating = outfit.outfit_weather_types.last.rating
        new_rating = "bad"
        params = { 'rating': new_rating }
        outfit_weather_type_params = { id: outfit.id, 'outfit_weather_type': params }

        patch(rating_url, outfit_weather_type_params.to_json, authorization_headers(user))

        outfit.reload

        expect(outfit.outfit_weather_types.last.rating).to eq old_rating
        expect(response).to have_http_status :bad_request
      end
    end
  end

  private

  def have_outfit_weather_types_json_path(response_body, path)
        expect(response_body).to have_json_path("#{path}/id")
        expect(response_body).to have_json_path("#{path}/created_at")
        expect(response_body).to have_json_path("#{path}/updated_at")
        expect(response_body).to have_json_path("#{path}/rating")
        expect(response_body).to have_json_path("#{path}/outfit_id")
        expect(response_body).to have_json_path("#{path}/weather_type_id")
  end

  def have_weather_types_json_path(response_body, path)
        expect(response_body).to have_json_path("#{path}/id")
        expect(response_body).to have_json_path("#{path}/created_at")
        expect(response_body).to have_json_path("#{path}/updated_at")
        expect(response_body).to have_json_path("#{path}/temp_range")
        expect(response_body).to have_json_path("#{path}/precip_type")
  end
end
