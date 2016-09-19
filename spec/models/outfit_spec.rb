require 'rails_helper'

describe Outfit do
  describe 'validations' do
    it { should validate_presence_of(:rating) }
    it { should validate_length_of(:notes).is_at_most(250) }
  end
end
