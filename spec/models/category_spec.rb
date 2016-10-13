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

  # describe 'icons' do
  #   it { should have_attached_file(:selected_icon) }
  #   it { should validate_attachment_presence(:selected_icon) }
  #   it { should validate_attachment_content_type(:selected_icon).
  #                 allowing('image/png', 'image/svg', 'image/svg+xml') }
  #   it { should have_attached_file(:unselected_icon) }
  #   it { should validate_attachment_presence(:unselected_icon) }
  #   it { should validate_attachment_content_type(:unselected_icon).
  #                 allowing('image/png', 'image/svg', 'image/svg+xml') }
  # end

  describe 'icons' do
    it { should have_attached_file(:selected_icon_1x) }
    it { should validate_attachment_presence(:selected_icon_1x) }
    it { should validate_attachment_content_type(:selected_icon_1x).
                  allowing('image/png') }
    it { should have_attached_file(:selected_icon_2x) }
    it { should validate_attachment_presence(:selected_icon_2x) }
    it { should validate_attachment_content_type(:selected_icon_2x).
                  allowing('image/png') }
    it { should have_attached_file(:selected_icon_3x) }
    it { should validate_attachment_presence(:selected_icon_3x) }
    it { should validate_attachment_content_type(:selected_icon_3x).
                  allowing('image/png') }
}
  end
end
