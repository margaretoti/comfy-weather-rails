require 'rails_helper'

describe AuthToken do
  describe '.generate' do
    it 'makes a secure token' do
      expect(AuthToken.generate).to be
      expect(AuthToken.generate).to be_a String
    end
  end

  describe '.expires_at' do
    it 'sets an expiration timestamp' do
      expect(AuthToken.expires_at).to be
      expect(AuthToken.expires_at).to be_a Time
    end

    it 'is valid for 60 days' do
      expect(AuthToken.expires_at).
        to be_within(1).of(token_expiration_date)
    end
  end

  def token_expiration_date
    ENV.fetch('TOKEN_DURATION_DAYS').to_i.days.from_now
  end
end
