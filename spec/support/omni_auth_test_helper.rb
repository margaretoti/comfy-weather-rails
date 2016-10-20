module OmniAuthTestHelper
  def self.valid_facebook_login_setup
    if Rails.env.test?
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
        provider: 'facebook',
        uid: '123545',
        info: {
          first_name: 'Harold',
          last_name:  'Sipe',
          email:      'test@example.com'
        },
        credentials: {
          token: '123456',
          expires_at: Time.current + 1.week
        },
        extra: {
          raw_info: {
            gender: 'male'
          }
        }
      })
    end
  end

  def self.invalid_facebook_login_setup
    if Rails.env.test?
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    end
  end

  def self.cleanup
    OmniAuth.config.mock_auth[:facebook] = nil
  end
end
