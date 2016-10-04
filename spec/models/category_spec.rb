require 'rails_helper'

describe Category do
  describe 'associations' do
    it { should have_many(:article_of_clothings) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:selected_icon) }
    it { should validate_presence_of(:unselected_icon) }
  end
end