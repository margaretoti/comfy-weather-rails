require 'rails_helper'

describe ArticleOfClothing do
  describe 'validations' do
    it { should belong_to(:user) }
    it { should have_many(:outfits) }
    it { should validate_presence_of(:description) }
  end
end
