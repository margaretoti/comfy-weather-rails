require 'rails_helper'

describe ArticleOfClothing do
  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:description) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
