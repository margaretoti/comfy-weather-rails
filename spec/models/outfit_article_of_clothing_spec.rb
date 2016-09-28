require 'rails_helper'

describe OutfitArticleOfClothing do
  describe 'associations' do
    it { should belong_to(:outfit) }
    it { should belong_to(:article_of_clothing) }
  end
end
