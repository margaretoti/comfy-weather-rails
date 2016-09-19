require 'rails_helper'

describe User do

=begin
  describe 'Associations' do
    it { should have_many(:outfits) }
  end
=end

  describe 'Validations' do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:uid)}
    it { should validate_presence_of(:oauth_token)}
    it { should validate_presence_of(:oauth_expires_at)}
  end
end
