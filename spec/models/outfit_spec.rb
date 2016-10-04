require 'rails_helper'

describe Outfit do
  describe 'validations' do
    it { should validate_presence_of(:user)
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
    it { should validate_length_of(:notes).is_at_most(250) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:outfit_article_of_clothings) }
    it { should have_many(:article_of_clothings).through(:outfit_article_of_clothings) }
  end
end
