require 'rails_helper'

describe ArticleOfClothing do
  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:description) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:outfit_article_of_clothings) }
    it { should have_many(:outfits).through(:outfit_article_of_clothings) }
  end
end
