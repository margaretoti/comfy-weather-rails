require 'rails_helper'

describe OutfitArticleOfClothing do
  describe 'associations' do
    it { should belong_to(:outfit) }
    it { should belong_to(:article_of_clothing) }
  end

  describe 'validationss' do
    it { should validate_presence_of(:outfit) }
    it { should validate_presence_of(:article_of_clothing) }
  end
end
