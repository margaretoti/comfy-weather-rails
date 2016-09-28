class AuthToken
  def self.generate
    new.generate
  end

  def generate
    SecureRandom.hex(20).encode('UTF-8')
  end

  def self.expires_at
    new.expires_at
  end

  def expires_at
    token_duration.days.from_now
  end

  private

  def token_duration
    ENV.fetch('TOKEN_DURATION_DAYS').to_i || 30
  end
end
