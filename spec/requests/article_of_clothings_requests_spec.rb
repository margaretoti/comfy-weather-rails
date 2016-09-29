require 'rails_helper'

describe 'ArticleOfClothing frequency' do
  it 'returns the number of outfits that a specific article of clothing belongs to' do
    article = create(:article_of_clothing)
    outfit_article = create_list(:outfit_article_of_clothing, 3, article_of_clothing: article)

    expect(article.frequency).to eq(3)
  end
end
