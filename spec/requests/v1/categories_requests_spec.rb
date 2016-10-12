require 'rails_helper'

describe 'Categories endpoints' do
  describe 'GET /categories' do
    it 'returns JSON for categories' do

      categories = create_list(:category, 10)

      get(categories_url, {}, accept_headers)

      expect(response).to have_http_status :ok
      expect(response.body).to have_json_size(10).at_path('categories')
    end
  end
end
