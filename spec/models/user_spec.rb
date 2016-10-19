require 'rails_helper'

describe User do
  describe 'Validations' do
    subject { create(:user) }
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

  describe 'Populating user fields from Koala' do
    it 'returns a user with all fields properly set' do
      stub_valid_facebook_avatar

      user = create(:user)

      allow_any_instance_of(Koala::Facebook::API).to receive(:get_object).and_return(user_attributes)
      user = User.populating_from_koala(user_attributes)

      expect(user.provider).to eq('facebook')
      expect(user.uid).to eq(user_attributes['id'])
      expect(user.name).to eq(user_attributes['name'])
      expect(user.email).to eq(user_attributes['email'])
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

  def user_attributes
    { "name"=>"Rachel Mathew",
      "picture"=>
      {
        "data"=>
        {
          "is_silhouette"=>false,
          "url"=> "https://scontent.xx.fbcdn.net/v/t1.0-1/p50x50/14520605_10153804905380933_8577943940592585981_n.jpg?oh=17272c39773cac26910cc27c02292332&oe=58671B1A"
        }
      },
      "id"=>"10152272830415933",
      "email"=>"baloneyslice@gmail.com"
    }
  end
end
