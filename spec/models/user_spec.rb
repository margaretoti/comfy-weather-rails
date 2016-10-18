require 'rails_helper'

describe User do
  describe 'Validations' do
    it { should have_many(:outfits) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:uid) }
    it { should validate_presence_of(:auth_token) }
    it { should validate_presence_of(:auth_expires_at) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should have_attached_file(:avatar) }
    it { should validate_attachment_content_type(:avatar).
                  allowing('image/png', 'image/gif').
                  rejecting('text/plain', 'text/xml') }
  end

  describe 'Authentication' do
    it 'returns a user with that token' do
      user = create(:user)

      user_from_token = User.for_auth(user.auth_token)

      expect(user_from_token).to eq(user)
    end

    it 'will not return a user if their token is expired' do
      user = create(:user, auth_expires_at: 1.day.ago)

      user_from_token = User.for_auth(user.auth_token)

      expect(user_from_token).to be_nil
    end
  end

  describe 'Reset token upon sign up/in' do
    it 'creates a new unique token for that user' do
      user = create(:user)
      token = user.auth_token

      user.reset_token!

      expect(user.auth_token).not_to eq(token)
    end

    it 'updates the expiration date' do
      user = create(:user, auth_expires_at: Time.current)

      user.reset_token!
      user.reload

      expect(user.auth_expires_at).
        to be_within(1).of(60.days.from_now)
    end
  end
end
