require 'rails_helper'

describe User do

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:uid) }
    it { should validate_presence_of(:oauth_token) }
    it { should validate_presence_of(:oauth_expires_at) }
    it { should have_attached_file(:avatar) }
    it { should validate_attachment_content_type(:avatar).
                  allowing('image/png', 'image/gif').
                  rejecting('text/plain', 'text/xml') }
  end
end
