require 'rails_helper'

describe Outfit do
  describe 'validations' do
    it { should validate_presence_of(:rating) }
  end
end
