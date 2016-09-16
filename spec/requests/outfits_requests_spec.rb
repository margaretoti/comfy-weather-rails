require 'rails_helper'

describe 'Outfits endpoints' do
  describe 'GET/outfits' do
    it 'returns JSON for outfits' do

      outfits = create_list(:outfit, 3)

      get(
        outfits_url,
        {},
        { 'Accept' => 'application/vnd.comfy-weather-server.com; version=1',
          'Content-Type' => 'application/json' }
      )
      
      expect(response).to have_http_status :ok
      expect(response.body).to have_json_size(3).at_path('outfits')
    end
  end
end
