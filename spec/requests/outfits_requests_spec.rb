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
      file = File.open('girl2.jpg', 'rb')
      # file.read.force_encoding(Encoding::UTF_8)

      outfit_params = { outfit: { rating: 1, notes: "comfy", photo: file} }
      post(outfits_url, outfit_params.to_json, accept_headers)

      expect(response).to have_http_status :ok
      expect(response.body).to have_json_path('outfit/id')
      expect(response.body).to have_json_path('outfit/created_at')
      expect(response.body).to have_json_path('outfit/updated_at')
      expect(response.body).to have_json_path('outfit/rating')
      expect(response.body).to have_json_path('outfit/photo')
      expect(response.body).to have_json_path('outfit/notes')
      expect(response.body).to have_json_path('outfit/is_public')
    end
  end
end
