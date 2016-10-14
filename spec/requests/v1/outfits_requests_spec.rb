require 'rails_helper'

describe 'Outfits endpoints' do
  describe 'GET /outfits?latitude=42.36&longitude=-71.06' do
    it 'returns JSON for comfy outfits that were wore in same temperature range' do
      stub_weather_api_request
      user = create(:user)
      outfits = create_list(:outfit_with_comfy_weather_types, 2)
      outfits << create(:outfit_with_toasty_weather_types)
      outfits << create(:outfit_with_chilly_weather_types)
      location_params = {
        latitude: 42.36,
        longitude: -71.06
      }

      get(outfits_url(location_params), {}, authorization_headers(user))

      parsed_body = JSON.parse(response.body)
      expect(response).to have_http_status :ok
      expect(response.body).to have_json_size(2).at_path('outfits')
      expect(parsed_body['outfits'][0]['rating']).to eq 'comfy'
      expect(parsed_body['outfits'][1]['rating']).to eq 'comfy'
    end
  end

  describe 'GET /outfit/:date' do
    it 'returns JSON for outfits created at that day' do
      user = create(:user)
      outfits = create_list(:outfit, 3)

      get(outfits_url, {}, authorization_headers(user))

      parsed_body = JSON.parse(response.body)
      expect(response).to have_http_status :ok
      expect(response.body).to have_json_size(3).at_path('outfits')
      expect(parsed_body['outfits'][0]['created_at'].to_date).to eq Time.now.to_date
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
        expect(response.body).to have_json_path('outfit/rating')
        have_weather_json_path(response.body, 'outfit/weather')
        have_article_of_clothings_json_path(response.body, 'outfit/article_of_clothings/0')
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
        stub_weather_api_request
        user = create(:user)
        outfit = create(:outfit_with_comfy_weather_types)
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
        outfit = create(:outfit_with_comfy_weather_types)
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

  def have_weather_json_path(response_body, path)
        expect(response_body).to have_json_path("#{path}/summary")
        expect(response_body).to have_json_path("#{path}/icon")
        expect(response_body).to have_json_path("#{path}/precipProbability")
        expect(response_body).to have_json_path("#{path}/temperature")
        expect(response_body).to have_json_path("#{path}/apparentTemperature")
  end

  def have_article_of_clothings_json_path(response_body, path)
    expect(response_body).to have_json_path("#{path}/id")
    expect(response_body).to have_json_path("#{path}/updated_at")
    expect(response_body).to have_json_path("#{path}/created_at")
    expect(response_body).to have_json_path("#{path}/description")
    expect(response_body).to have_json_path("#{path}/frequency")
  end
end
