require 'rails_helper'

describe User do

=begin
  describe 'Associations' do
    it { should have_many(:outfits) }
  end
=end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:uid) }
    it { should validate_presence_of(:oauth_token) }
    it { should validate_presence_of(:oauth_expires_at) }
  end

  describe 'Avatar' do
    it { should have_attached_file(:avatar) }
    it { should validate_attachment_content_type(:avatar).
                  allowing('image/png', 'image/gif').
                  rejecting('text/plain', 'text/xml') }
    #it { should validate_attachment_size(:avatar).
                #less_than(2.megabytes) }
  end
end
