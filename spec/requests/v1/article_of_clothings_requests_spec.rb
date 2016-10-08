require 'rails_helper'

describe 'ArticlesOfClothing endpoints' do
  describe 'GET /article_of_clothings' do
    it 'returns the JSON for the existing articles of clothing' do
      user = create(:user)
      articles = create_list(:article_of_clothing, 3, user: user)

      get(article_of_clothings_url, {}, authorization_headers(user))
      
      expect(response).to have_http_status :ok
      expect(response.body).to have_json_size(3).at_path('article_of_clothings')
    end
  end

  describe 'POST /article_of_clothings' do
    it 'returns 200 status and the JSON for the articles of clothing' do

      user = create(:user)
      category = create(:category)
      article_of_clothing_params = {
        article_of_clothing: {
          description: "a blue item",
          category_id: category.id
        }
      }

      post(article_of_clothings_url, article_of_clothing_params.to_json, authorization_headers(user))
      expect(response).to have_http_status :ok
      expect(response.body).to have_json_path('article_of_clothing/id')
      expect(response.body).to have_json_path('article_of_clothing/created_at')
      expect(response.body).to have_json_path('article_of_clothing/updated_at')
      expect(response.body).to have_json_path('article_of_clothing/description')
    end
  end
end
