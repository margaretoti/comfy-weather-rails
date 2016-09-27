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
      base64_string = Base64.encode64(File.open('spec/fixtures/image1.jpg', 'rb').read)

      outfit_params = { outfit: { rating: 1, notes: "comfy", photo: "data:image/jpg;base64,#{base64_string}"  } }
      post(outfits_url, outfit_params.to_json, accept_headers)

      expect(response).to have_http_status :ok
      expect(response.body).to have_json_path('outfit/id')
      expect(response.body).to have_json_path('outfit/created_at')
      expect(response.body).to have_json_path('outfit/updated_at')
      expect(response.body).to have_json_path('outfit/rating')
      expect(response.body).to have_json_path('outfit/photo_url')
      expect(response.body).to have_json_path('outfit/notes')
      expect(response.body).to have_json_path('outfit/is_public')
    end
  end
end
