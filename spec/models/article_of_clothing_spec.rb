require 'rails_helper'

describe ArticleOfClothing do
  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:description) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:category) }
    it { should have_many(:outfit_article_of_clothings) }
    it { should have_many(:outfits).through(:outfit_article_of_clothings) }
  end

  describe 'model methods' do
    describe 'ArticleOfClothing frequency' do
      it 'returns the number of outfits that a specific article of clothing belongs to' do
        article = create(:article_of_clothing)
        outfit_article = create_list(:outfit_article_of_clothing, 3, article_of_clothing: article)

        expect(article.frequency).to eq(3)
      end
    end
  end
end
