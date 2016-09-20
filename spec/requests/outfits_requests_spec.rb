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
      outfit_params = { outfit: { rating: 1, notes: "comfy" } }
      post(outfits_url, outfit_params.to_json, accept_headers)

      # binding.pry
      expect(response).to have_http_status :ok # okay = 200, created = 201
      expect(response.body).to have_json_path('outfit/id')

      # test path for each attribute
    end
  end
end
