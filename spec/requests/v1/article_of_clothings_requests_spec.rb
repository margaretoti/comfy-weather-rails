require 'rails_helper'

describe 'ArticleOfClothing frequency' do
  it 'returns the number of outfits that a specific article of clothing belongs to' do
    article = create(:article_of_clothing)
    outfit_article = create_list(:outfit_article_of_clothing, 3, article_of_clothing: article)

    expect(article.frequency).to eq(3)
  end
end

describe 'ArticlesOfClothing endpoints' do
  describe 'GET /article_of_clothings' do
    it 'returns the JSON for the existing articles of clothing' do

      articles = create_list(:article_of_clothing, 3)

      get(article_of_clothings_url, {}, accept_headers)
      binding.pry
      expect(response).to have_http_status :ok
      expect(response.body).to have_json_size(3).at_path('article_of_clothings')
    end
  end

#   describe 'POST /articles_of_clothing' do
#     it '' do
#     end
#   end
end
