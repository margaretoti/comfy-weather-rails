require 'rails_helper'

RSpec.describe Outfit, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  
  # describe 'associations' do
  #   it { should belong_to(:user) }
  # end

  describe 'validations' do
    it { should validate_presence_of(:rating) }

  end

end
