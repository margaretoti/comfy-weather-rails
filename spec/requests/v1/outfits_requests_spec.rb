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
      expect(parsed_body['outfits'][0]['latest_rating']).to eq 'comfy'
      expect(parsed_body['outfits'][1]['latest_rating']).to eq 'comfy'
    end
  end

  describe 'GET /outfit/:date' do
    it "returns JSON for today's outfit if no date specified" do
      stub_weather_api_request

      user = create(:user)
      outfit = create(:outfit)
      date_params = nil

      get(show_outfit_url(date_params), {}, authorization_headers(user))

      parsed_body = JSON.parse(response.body)
      expect(response).to have_http_status :ok
      expect(response.body).to have_json_path('outfit')
      expect(parsed_body['outfit']['created_at'].to_date).to eq Time.current.to_date
    end

    it "returns JSON for that day's outfit if date is Oct 12th 2016" do
      stub_weather_api_request

      user = create(:user)
      outfit = create(:outfit, created_at: Date.new(2016, 10, 12))
      date_params = {
        date: "12-10-2016"
      }

      get(show_outfit_url(date_params), {}, authorization_headers(user))

      parsed_body = JSON.parse(response.body)
      expect(response).to have_http_status :ok
      expect(response.body).to have_json_path('outfit')
      expect(parsed_body['outfit']['created_at'].to_date).to eq Date.new(2016, 10, 12)
    end

    it "returns JSON for today's outfit if no outfit was created on Oct 12th 2016" do
      stub_weather_api_request

      user = create(:user)
      outfit = create(:outfit)
      date_params = {
        date: "12-10-2016"
      }

      get(show_outfit_url(date_params), {}, authorization_headers(user))

      parsed_body = JSON.parse(response.body)
      expect(response).to have_http_status :ok
      expect(response.body).to have_json_path('outfit')
      expect(parsed_body['outfit']['created_at'].to_date).to eq Time.current.to_date
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
        expect(response.body).to have_json_path('outfit/latest_rating')
        have_weather_json_path(response.body, 'outfit/weather')
        have_article_of_clothings_json_path(response.body, 'outfit/article_of_clothings/0')
        have_article_of_clothings_json_path(response.body, 'outfit/article_of_clothings/1')
        have_article_of_clothings_json_path(response.body, 'outfit/article_of_clothings/2')
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

    context 'with rating' do
      it 'returns 200 status and the JSON for an outfit with rating' do
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
          rating: "comfy",
          article_of_clothings: articles.map(&:id)
        }

        post(outfits_url, outfit_params.to_json, authorization_headers(user))

        parsed_body = JSON.parse(response.body)
        expect(parsed_body['outfit']['latest_rating']).to eq 'comfy'
        have_weather_json_path(response.body, 'outfit/weather')
        have_article_of_clothings_json_path(response.body, 'outfit/article_of_clothings/0')
        have_article_of_clothings_json_path(response.body, 'outfit/article_of_clothings/1')
        have_article_of_clothings_json_path(response.body, 'outfit/article_of_clothings/2')
      end
    end
  end

  describe 'GET /recommendation' do
    describe 'recommendation behavior based on CHILLY, TOASTY, and COMFY ratings
    available for each temperature range' do
      context 'only outfits with a rating of comfy exist for the temp range' do
        it 'returns a 200 status and JSON of the recommended outfit' do
          stub_weather_api_request(53)

          user = create(:user)
          outfit1 = create(:outfit_with_comfy_weather_types, created_at: DateTime.new(2016,10,18), user_id: user.id)
          outfit2 = create(:outfit_with_comfy_weather_types, created_at: DateTime.new(2016,6,6), user_id: user.id)
          outfit3 = create(:outfit_with_comfy_weather_types, created_at: DateTime.new(2016,7,7), user_id: user.id)
          outfit4 = create(:outfit_with_comfy_weather_types, created_at: DateTime.new(2016,8,8), user_id: user.id)
          outfit5 = create(:outfit_with_comfy_weather_types, created_at: DateTime.new(2016,9,9), user_id: user.id)

          location_params = {
            latitude: 42.36,
            longitude: -71.06
          }

          get(recommendation_url(location_params), {} , authorization_headers(user))

          parsed_body = JSON.parse(response.body)
          expect(response).to have_http_status :ok
          expect(response.body).to have_json_size(1)
          expect(parsed_body['outfit']['created_at'].to_date).to eq Date.new(2016,6, 6)
        end
      end

      context 'no outfits with a comfy rating exist, but outfits with rating
      toasty one temp range above the current temperature exist' do
        it 'returns a 200 status and JSON of the outfit rated toasty one temp
        range above the current temp' do
          stub_weather_api_request(93)

          user = create(:user)
          outfit6 = create(:outfit_with_toasty_weather_types, created_at: DateTime.new(2016,10,18), user_id: user.id)
          outfit7 = create(:outfit_with_toasty_weather_types, created_at: DateTime.new(2016,6,6), user_id: user.id)
          outfit8 = create(:outfit_with_toasty_weather_types, created_at: DateTime.new(2016,7,7), user_id: user.id)
          outfit9 = create(:outfit_with_toasty_weather_types, created_at: DateTime.new(2016,8,8), user_id: user.id)
          outfit10 = create(:outfit_with_toasty_weather_types, created_at: DateTime.new(2016,9,9), user_id: user.id)

          location_params = {
            latitude: 42.36,
            longitude: -71.06
          }

          get(recommendation_url(location_params), {} , authorization_headers(user))

          parsed_body = JSON.parse(response.body)
          expect(response).to have_http_status :ok
          expect(response.body).to have_json_size(1)
          expect(parsed_body['outfit']['created_at'].to_date).to eq Date.new(2016,6, 6)
        end
      end

      context 'no outfits with rating comfy or toasty exist, but outfits with
      rating chilly one temp range below the current temperature exist' do
        it 'returns a 200 status and JSON of the outfit rated chilly one temp
        range below the current temp' do
          stub_weather_api_request(8)

          user = create(:user)
          outfit11 = create(:outfit_with_chilly_weather_types, created_at: DateTime.new(2016,10,18), user_id: user.id)
          outfit12 = create(:outfit_with_chilly_weather_types, created_at: DateTime.new(2016,6,6), user_id: user.id)
          outfit13 = create(:outfit_with_chilly_weather_types, created_at: DateTime.new(2016,7,7), user_id: user.id)
          outfit14 = create(:outfit_with_chilly_weather_types, created_at: DateTime.new(2016,8,8), user_id: user.id)
          outfit15 = create(:outfit_with_chilly_weather_types, created_at: DateTime.new(2016,9,9), user_id: user.id)

          location_params = {
            latitude: 42.36,
            longitude: -71.06
          }

          get(recommendation_url(location_params), {} , authorization_headers(user))

          parsed_body = JSON.parse(response.body)
          expect(response).to have_http_status :ok
          expect(response.body).to have_json_size(1)
          expect(parsed_body['outfit']['created_at'].to_date).to eq Date.new(2016,6, 6)
        end
      end

      context 'no outfits with a comfy rating exist, but outfits with
      rating chilly 1 temp range below the current temperature exist and
      outfits with rating toasty one temp range above the current
      temperature exist' do
        it 'returns a 200 status and JSON of the outfit worn longest ago' do
          stub_weather_api_request(91)

          user = create(:user)
          chilly_rated_outfit = create(:outfit_with_chilly_weather_types_85,
                                       created_at: DateTime.new(2016,9,9), user_id: user.id) # range 85 to 89 - outfits rated chilly
          toasty_rated_outfit = create(:outfit_with_chilly_weather_types,
                                       created_at: DateTime.new(2016,10,10), user_id: user.id) # range 95 to 100 - outfits rated toasty

          location_params = {
            latitude: 42.36,
            longitude: -71.06
          }

          get(recommendation_url(location_params), {} , authorization_headers(user))

          parsed_body = JSON.parse(response.body)
          expect(response).to have_http_status :ok
          expect(response.body).to have_json_size(1)
          expect(parsed_body['outfit']['created_at'].to_date).to eq Date.new(2016,9,9)
        end
      end

      context 'no outfits with a comfy rating exist, and outfits with a toasty
      or chilly rating are 2+ temp ranges below or above the current temp
      range' do
        it 'returns a 200 status and empty JSON' do
          stub_weather_api_request(75)

          user = create(:user)
          outfit16 = create(:outfit_with_chilly_weather_types)
          outfit17 = create(:outfit_with_toasty_weather_types)

          # temperature_params = { temperature: 75 }
          location_params = {
             latitude: 42.36,
             longitude: -71.06
          }

          get(recommendation_url(location_params), {} , authorization_headers(user))
          expect(response).to have_http_status :ok
          expect(response.body).to eq('null')
        end
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
    expect(response_body).to have_json_path("#{path}/category_id")
    expect(response_body).to have_json_path("#{path}/category_name")
  end
end
