require 'rails_helper'

describe 'Outfits endpoints' do
  describe 'GET/outfits' do
    it 'returns JSON for outfits' do

      user = create(:user)
      outfits = create_list(:outfit, 3)

      get(outfits_url, {}, authorization_headers(user))

      expect(response).to have_http_status :ok
      expect(response.body).to have_json_size(3).at_path('outfits')
    end
  end

  # describe 'POST/outfits' do
  #   it 'returns 200 status and the JSON for an outfit' do
  #     base64_string = Base64.encode64(File.open('spec/fixtures/image1.jpg', 'rb').read)
  #
  #     user = create(:user)
  #     outfit_params = {
  #       outfit: {
  #         notes: "comfy",
  #         photo: "data:image/jpg;base64,#{base64_string}"
  #       }
  #     }
  #
  #     post(outfits_url, outfit_params.to_json, authorization_headers(user))
  #
  #     expect(response).to have_http_status :ok
  #     expect(response.body).to have_json_path('outfit/id')
  #     expect(response.body).to have_json_path('outfit/created_at')
  #     expect(response.body).to have_json_path('outfit/updated_at')
  #     expect(response.body).to have_json_path('outfit/photo_url')
  #     expect(response.body).to have_json_path('outfit/notes')
  #     expect(response.body).to have_json_path('outfit/is_public')
  #   end
  # end

  describe 'POST/outfits' do
    it 'returns 200 status and the JSON for an outfit' do
      base64_string = Base64.encode64(File.open('spec/fixtures/image1.jpg', 'rb').read)

      user = create(:user)
      # articles = create_list(:article_of_clothing, 3, user: user)
      # outfit_articles = create_list(:outfit_article_of_clothing, 3, article_of_clothing: articles)

      outfit_params = {
        outfit: {
          latitude: 37.792,
          longitude: -122.393,
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
    end
  end
end
